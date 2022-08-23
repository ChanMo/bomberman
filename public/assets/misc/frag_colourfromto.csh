#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
//uniform sampler2D CC_Texture0;

//uniform ivec3 fromColourFrom;
//uniform ivec3 fromColourTo;

uniform vec3 colourTo;
uniform float myOpacity;

// Bomberiin speksattu: ainoastaan blue-kanavaa käytetään sävyn laskemiseen, 16 eri vaihtoehtoa

void main()
{
	vec4 normalColor = texture2D( CC_Texture0, fract( vec2( v_texCoord.x, v_texCoord.y ) ) );
	
	// opacity hax, voi ajaa FadeTo -actioneita
	float alphaTmp = normalColor.a * myOpacity;
	normalColor = vec4( normalColor.r * myOpacity, normalColor.g * myOpacity, normalColor.b * myOpacity, alphaTmp );
	
	ivec4 colorInt = ivec4( int( normalColor.x * 255.0 ), int( normalColor.y * 255.0 ), int( normalColor.z * 255.0 ), int( normalColor.w * 255.0 ) );

    if( colorInt.y >= ( colorInt.x + 10 ) && colorInt.y >= ( colorInt.z + 10 ) && colorInt.w >= 100 )	// jos on eniten vihreää ja näkyvä
    {
		//float darknessValueFromZeroToOne = ( float( colorInt.y ) / 255.0 );	// float ( variable ) operation does not work in iOS.
        float darknessValueFromZeroToOne = normalColor.y;		// isompi kerroin tässä jälessä saa aikaan suuremman vaihteluvälin, kasvaa tummemmaksi
		
		gl_FragColor = vec4( colourTo.x * darknessValueFromZeroToOne / 255.0,
							colourTo.y * darknessValueFromZeroToOne / 255.0, 
							colourTo.z * darknessValueFromZeroToOne / 255.0, 
							normalColor.w );

	}
	// ulkona rangesta
	else
	{
		gl_FragColor = vec4( normalColor );
	}

	// testiä
	//gl_FragColor = texture2D( CC_Texture0, v_texCoord );
}
