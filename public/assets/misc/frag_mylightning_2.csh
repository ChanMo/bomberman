#ifdef GL_ES
precision lowp float;
#endif

varying vec2 v_texCoord;
//varying vec4 v_fragmentColor;

uniform mat4 mDataPointsMatrix;

void main()
{
	vec2 LIGHTNING_POINTS[ 8 ];
	for( int i = 0; i < 8; ++i )
		LIGHTNING_POINTS[ i ] = vec2( -1.0, -1.0 );
	
	LIGHTNING_POINTS[ 0 ] = mDataPointsMatrix[ 0 ].xy;
	LIGHTNING_POINTS[ 1 ] = mDataPointsMatrix[ 0 ].zw;
	LIGHTNING_POINTS[ 2 ] = mDataPointsMatrix[ 1 ].xy;
	LIGHTNING_POINTS[ 3 ] = mDataPointsMatrix[ 1 ].zw;
	LIGHTNING_POINTS[ 4 ] = mDataPointsMatrix[ 2 ].xy;
	LIGHTNING_POINTS[ 5 ] = mDataPointsMatrix[ 2 ].zw;
	LIGHTNING_POINTS[ 6 ] = mDataPointsMatrix[ 3 ].xy;
	LIGHTNING_POINTS[ 7 ] = mDataPointsMatrix[ 3 ].zw;
	
	vec4 newPixelColor = vec4( 0, 0, 0, 0 );
	
	for( int i = 1; i < 8; ++i )
	{
		vec2 myPos = vec2( v_texCoord.x, v_texCoord.y );
		
		if( LIGHTNING_POINTS[ i ].x > 0.0 && LIGHTNING_POINTS[ i ].y > 0.0 )
		{
			vec2 pointA = LIGHTNING_POINTS[ i - 1 ];
			vec2 pointB = LIGHTNING_POINTS[ i ];
					
			if( ( myPos.x >= pointA.x && myPos.x <= pointB.x ) || ( myPos.x <= pointA.x && myPos.x >= pointB.x ) )
			{
				float yOffset = pointA.y - 0.5;
				float yDiff = ( pointB.y - pointA.y ) * ( ( v_texCoord.x - pointA.x ) / ( pointB.x - pointA.x ) );
				
				newPixelColor = texture2D( CC_Texture0, fract( vec2( v_texCoord.x, v_texCoord.y + yOffset + yDiff ) ) );
			}
		}
	}

	gl_FragColor = vec4( newPixelColor.x, newPixelColor.y, newPixelColor.z, newPixelColor.w );
	//gl_FragColor = vec4( 0, 0, 0, 1 );
}
