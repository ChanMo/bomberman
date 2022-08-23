#ifdef GL_ES
precision highp float;
#endif

varying vec2 v_texCoord;
varying vec4 v_fragmentColor;
//uniform sampler2D CC_Texture0;

void main()
{
	vec4 normalColor = texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y ) );
	gl_FragColor = normalColor;
}
