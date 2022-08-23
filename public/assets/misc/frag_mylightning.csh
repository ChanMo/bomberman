#ifdef GL_ES
precision highp float;
#endif

varying vec2 v_texCoord;
varying vec4 v_fragmentColor;

//uniform sampler2D CC_Texture0;

uniform float mTime;
uniform float mRandomOffset;	// ettei näytä kaikki samalta
uniform int mFinalTile;			// päätypala?

const float changeTimeInterval = 0.01;
//const float changeTimeInterval = 2.0;	// testauksiin, voi seurata kauemmin yhtä vaihetta

// apufunktio, jos myPos on riittävän lähellä pointPos niin palauttaa true, muuten false
bool shouldColorPixelImplAsDot( vec2 myPos, vec2 pointPos )
{
	float treshold = 0.01;
	
	if( myPos.x >= pointPos.x - treshold && myPos.x <= pointPos.x + treshold && myPos.y >= pointPos.y - treshold && myPos.y <= pointPos.y + treshold )
		return true;
	else
		return false;
}

// apufunktio, laskee pisteen ja kahden pisteen määräämän suoran välisen etäisyyden
float DistToLine(vec2 pt1, vec2 pt2, vec2 testPt)
{
	vec2 lineDir = pt2 - pt1;
	vec2 perpDir = vec2( lineDir.y, - lineDir.x );
	vec2 dirToPt1 = pt1 - testPt;
	return abs( dot( normalize( perpDir ), dirToPt1 ) );
}

// apufunktio, kertoo kuuluuko piste kahden pisteen määräämälle viivalle
bool shouldColorPixelImplAsLine( vec2 myPos, vec2 pointA, vec2 pointB )
{
	if( ( myPos.x > pointA.x && myPos.x < pointB.x ) || ( myPos.x < pointA.x && myPos.x > pointB.x ) )
	{
		float distance = DistToLine( pointA, pointB, myPos );
		if( distance < 0.001 )
			return true;
	}
	
	return false;
}

// väritysfunktio, kertoo millä värillä pikseli tulisi värjätä
// jos riittävän lähellä viivaa niin valkoinen, sitten sininen fadetettuna ja lopuksi väritön
vec4 calculateColorForPixelImplAsLine( vec2 myPos, vec2 pointA, vec2 pointB, bool fadeOut, int amountOfSectionsLeftAfterThisOne )
{
	float distance = DistToLine( pointA, pointB, myPos );
	
	//float fullWhiteWidth = 0.06;
	//float fadeFromWhiteToBlue = 0.12;
	//float fadeFromBlueToTransWhite = 0.18;
	//float fadeFromTransWhiteToTransparent = 0.30;
	
	float multiplier = 1.0;
	float fullWhiteWidth = 0.06 * multiplier;
	float fadeFromWhiteToBlue = 0.12 * multiplier;
	float fadeFromBlueToTransWhite = 0.18 * multiplier;
	float fadeFromTransWhiteToTransparent = 0.30 * multiplier;
	
	
	vec4 baseColor = vec4( 0.0 / 256.0, 0.0 / 256.0, 255.0 / 255.0, 1.0 );
	//vec4 baseColor = vec4( 0, 0, 1, 1 );
	
	if( fadeOut == true && amountOfSectionsLeftAfterThisOne <= 2 )
	{
		float smooth = 1.0 - ( myPos.x - pointA.x ) / ( pointB.x - pointA.x );
		smooth = smooth;
		
		//smooth = pow( smooth, 0.7 );
		smooth = clamp( smooth, 0.0, 1.0 );
		
		if( amountOfSectionsLeftAfterThisOne == 0 )
			smooth = smooth * 0.3;
		else if( amountOfSectionsLeftAfterThisOne == 1 )
			smooth = 0.3 + smooth * 0.3;
		else 
			smooth = 0.6 + smooth * 0.4;
		
		baseColor = vec4( 0.0 / 256.0, 0.0 / 256.0, 255.0 / 255.0, smooth );
		
		//vec4 newColor = vec4( 0, 0, 1, smooth );
		//return newColor;
	}
			
	
	if( distance < fullWhiteWidth )
		return vec4( 1, 1, 1, baseColor.w );
	else if( distance >= fullWhiteWidth && distance <= fadeFromWhiteToBlue )
	{
		float smooth = 1.0 - ( fadeFromWhiteToBlue - distance ) / ( fadeFromWhiteToBlue - fullWhiteWidth );
		return vec4( 
			1.0 - ( 1.0 - baseColor.x ) * smooth, 
			1.0 - ( 1.0 - baseColor.y ) * smooth, 
			1.0 - ( 1.0 - baseColor.z ) * smooth, 
			baseColor.w 
		);
		
		//return vec4( smooth, smooth, 1, 1 );
	}
	else if( distance >= fadeFromWhiteToBlue && distance <= fadeFromBlueToTransWhite )
	{
		float smooth = ( fadeFromBlueToTransWhite - distance ) / ( fadeFromBlueToTransWhite - fadeFromWhiteToBlue );	// 1 --> 0
		
		return vec4( 
			1.0 - ( 1.0 - baseColor.x ) * smooth, 
			1.0 - ( 1.0 - baseColor.y ) * smooth, 
			1.0 - ( 1.0 - baseColor.z ) * smooth, 
			baseColor.w
		);
		
		//return vec4( smooth, smooth, 1, 1.0 - smooth / 2.0 );
		//return vec4( baseColor.x * smooth, baseColor.y * smooth, baseColor.z * smooth, baseColor.w - smooth / 2.0 );
	}
	else if( distance >= fadeFromBlueToTransWhite && distance < fadeFromTransWhiteToTransparent)
	{
		float smooth = ( fadeFromTransWhiteToTransparent - distance ) / ( fadeFromTransWhiteToTransparent - fadeFromBlueToTransWhite );
		return vec4( 1, 1, 1, baseColor.w * smooth * 0.75 );
	}
	else 
		return vec4( 0, 0, 0, 0 );
}

void main()
{
	float valueA = mTime * 1000.0;
	float valueB = changeTimeInterval * 1000.0;
	float iterationValue = mRandomOffset + valueA / valueB;	// tää saa arvoja 0 .... n
	
	// lightning points saa pisteet minkä väliin vedetään viivat järjestyksessä, -1 kertoo ettei oo käytös
	vec2 LIGHTNING_POINTS[ 8 ];
	for( int i = 0; i < 8; ++i )
		LIGHTNING_POINTS[ i ] = vec2( -1.0, -1.0 );
	
	// alkuperäiset sijainnit pisteille
	//int AMOUNT_OF_POINTS_IN_THIS_ITERATION = 6 + ( iterationValue % 3 );
	float AMOUNT_OF_POINTS_IN_THIS_ITERATION_FLOAT = floor( 6.0 + ( mod( iterationValue, 3.0 ) ) );
	int AMOUNT_OF_POINTS_IN_THIS_ITERATION = int( AMOUNT_OF_POINTS_IN_THIS_ITERATION_FLOAT );
	
	//for( int i = 0; i < AMOUNT_OF_POINTS_IN_THIS_ITERATION; ++i )
	for( int i = 0; i < 8; ++i )
	{
		if( i < AMOUNT_OF_POINTS_IN_THIS_ITERATION )
		{
			float fi = float( i );
			LIGHTNING_POINTS[ i ] = vec2( 1.0 / ( AMOUNT_OF_POINTS_IN_THIS_ITERATION_FLOAT - 1.0 ) * fi, 0.5 );
		}
	}
	
	// hajotetaan vähän sijainteja x ja y -suunnissa
	//for( int i = 0; i < AMOUNT_OF_POINTS_IN_THIS_ITERATION; ++i )
	for( int i = 0; i < 8; ++i )
	{
		if( i < AMOUNT_OF_POINTS_IN_THIS_ITERATION )
		{
			float fi = float( i );
			vec2 tempPos = LIGHTNING_POINTS[ i ];
			
			float newX = tempPos.x;
			float newY = ( 6.0 + sin( iterationValue + ( fi * 2.0 ) ) ) / 12.0;
			//float newY = abs( sin( iterationValue + i ) );
			
			if( i == 0 || i == AMOUNT_OF_POINTS_IN_THIS_ITERATION - 1 )
				newY = 0.5;
			
			LIGHTNING_POINTS[ i ] = vec2(
				newX,
				newY
			);
		}
	}
	
	// tsekataan värjätäänkö pikseli
	bool shouldColorPixelAsWhite = false;
	vec4 newPixelColor = vec4( 0, 0, 0, 0 );
	//for( int i = 0; i < AMOUNT_OF_POINTS_IN_THIS_ITERATION; ++i )
	for( int i = 1; i < 8; ++i )
	{
		if( i < AMOUNT_OF_POINTS_IN_THIS_ITERATION )
		{
			vec2 myPos = vec2( v_texCoord.x, v_texCoord.y );
			
			if( LIGHTNING_POINTS[ i ].x > 0.0 && LIGHTNING_POINTS[ i ].y > 0.0 )
			{
				// pisteiden piirto
				//if( shouldColorPixelImplAsDot( myPos, LIGHTNING_POINTS[ i ] ) )
				//{
				//	shouldColorPixelAsWhite = true;
				//}
				// x -koordinaatin mukaan värjäys
				//else 	
				if( i > 0 )
				{
					vec2 pointA = LIGHTNING_POINTS[ i - 1 ];
					vec2 pointB = LIGHTNING_POINTS[ i ];
					
					bool fadeOut = false;
					if( mFinalTile == 1 )
						fadeOut = true;
					
					if( ( myPos.x >= pointA.x && myPos.x <= pointB.x ) || ( myPos.x <= pointA.x && myPos.x >= pointB.x ) )
					{
						newPixelColor = calculateColorForPixelImplAsLine( myPos, pointA, pointB, fadeOut, AMOUNT_OF_POINTS_IN_THIS_ITERATION - 1 - i );
					}
				}
			}
		}
	}

	if( shouldColorPixelAsWhite )
		gl_FragColor = vec4( 1.0, 1.0, 1.0, 1.0 );
	else
		gl_FragColor = vec4( newPixelColor.x, newPixelColor.y, newPixelColor.z, newPixelColor.w );
}
