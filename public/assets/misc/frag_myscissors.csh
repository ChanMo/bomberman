#ifdef GL_ES
precision highp float;
#endif

varying vec2 v_texCoord;
varying vec4 v_fragmentColor;
//uniform sampler2D CC_Texture0;

uniform vec4 scissor1;
uniform vec4 scissor2;
uniform vec4 scissor3;
uniform vec4 scissor4;

//uniform float myOpacity;
uniform vec4 colourTo;

void main()
{
	vec4 normalColor = texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y ) );

	if( v_texCoord.x >= scissor1.x && v_texCoord.x <= scissor1.x + scissor1.z && v_texCoord.y >= scissor1.y && v_texCoord.y <= scissor1.y + scissor1.w )
		gl_FragColor = vec4( 1, 1, 1, 0.0 );
	else if( v_texCoord.x >= scissor2.x && v_texCoord.x <= scissor2.x + scissor2.z && v_texCoord.y >= scissor2.y && v_texCoord.y <= scissor2.y + scissor2.w )
		gl_FragColor = vec4( 1, 1, 1, 0.0 );
	else if( v_texCoord.x >= scissor3.x && v_texCoord.x <= scissor3.x + scissor3.z && v_texCoord.y >= scissor3.y && v_texCoord.y <= scissor3.y + scissor3.w )
		gl_FragColor = vec4( 1, 1, 1, 0.0 );
	else if( v_texCoord.x >= scissor4.x && v_texCoord.x <= scissor4.x + scissor4.z && v_texCoord.y >= scissor4.y && v_texCoord.y <= scissor4.y + scissor4.w )
		gl_FragColor = vec4( 1, 1, 1, 0.0 );
	else
		gl_FragColor = vec4( colourTo.x, colourTo.y, colourTo.z, colourTo.w );
		
}
