#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
varying vec4 v_fragmentColor;
uniform sampler2D CC_Texture0;

uniform float timeTotal;
uniform vec2 speedVec;
uniform vec2 blurSize;

void main()
{
	vec4 sum = vec4( 0.0 );
	vec2 realBlur = vec2( blurSize.x * speedVec.x, blurSize.y * speedVec.y );
	
	sum += texture2D( CC_Texture0, v_texCoord - 4.0 * realBlur ) * 0.05;
	sum += texture2D( CC_Texture0, v_texCoord - 3.0 * realBlur ) * 0.09;
	sum += texture2D( CC_Texture0, v_texCoord - 2.0 * realBlur ) * 0.12;
	sum += texture2D( CC_Texture0, v_texCoord - 1.0 * realBlur ) * 0.15;
	sum += texture2D( CC_Texture0, v_texCoord                  ) * 0.16;
	sum += texture2D( CC_Texture0, v_texCoord + 1.0 * realBlur ) * 0.15;
	sum += texture2D( CC_Texture0, v_texCoord + 2.0 * realBlur ) * 0.12;
	sum += texture2D( CC_Texture0, v_texCoord + 3.0 * realBlur ) * 0.09;
	sum += texture2D( CC_Texture0, v_texCoord + 4.0 * realBlur ) * 0.05;

	gl_FragColor = sum * v_fragmentColor;
}
