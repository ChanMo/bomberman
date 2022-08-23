#ifdef GL_ES
precision highp float;
#endif

varying vec2 v_texCoord;
varying vec4 v_fragmentColor;
uniform sampler2D CC_Texture0;

uniform float tresholdForColor;
uniform vec3 brightPassColor;

void main()
{
	// get the normal color from the texture
	vec4 normalColor = texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y ) );
	
	// calculate the sum from the pixel components
	float shininess = normalColor.r + normalColor.g + normalColor.b;
	float treshold = tresholdForColor;
	float tresholdMin = treshold * 0.6;
	float red = normalColor.r;
	float green = normalColor.g;
	float blue = normalColor.b;

	// pass the fragment if it passes the treshold
	if( red > treshold && green > treshold && blue > treshold )
	{
		gl_FragColor = vec4( brightPassColor.r, brightPassColor.g, brightPassColor.b, 1 );
		//gl_FragColor = vec4( normalColor.r, normalColor.g, normalColor.b, 1 );
	}
	// pass with faded alpha
	else if( red > tresholdMin && green > tresholdMin && blue > tresholdMin )
	{
		float sum = red + green + blue;
		float newAlpha = ( sum - 3.0 * tresholdMin ) / ( 3.0 * ( treshold - tresholdMin ) );
		gl_FragColor = vec4( brightPassColor.r, brightPassColor.g, brightPassColor.b, newAlpha );
		//gl_FragColor = vec4( normalColor.r, normalColor.g, normalColor.b, newAlpha );
	}
	// set invisible
	else
	{
		//discard;
		gl_FragColor = vec4( 0.0, 0.0, 0.0, 1.0 );
	}
}
