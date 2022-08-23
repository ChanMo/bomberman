#ifdef GL_ES
precision highp float;
#endif

varying vec2 v_texCoord;
varying vec4 v_fragmentColor;
uniform sampler2D CC_Texture0;

uniform float blurSize;
uniform int blurMethod;

void main()
{
	vec4 sum = vec4( 0.0 );
	float blurAmount = blurSize * 1.0;
	
	if( blurMethod == 0 )
	{
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 7.0 * blurAmount ) ) * 0.0044;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 6.0 * blurAmount ) ) * 0.0089;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 5.0 * blurAmount ) ) * 0.0215;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 4.0 * blurAmount ) ) * 0.0443;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 3.0 * blurAmount ) ) * 0.0776;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 2.0 * blurAmount ) ) * 0.1158;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 1.0 * blurAmount ) ) * 0.1473;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y ) ) * 0.1595;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 1.0 * blurAmount ) ) * 0.1473;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 2.0 * blurAmount ) ) * 0.1158;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 3.0 * blurAmount ) ) * 0.0776;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 4.0 * blurAmount ) ) * 0.0443;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 5.0 * blurAmount ) ) * 0.0215;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 6.0 * blurAmount ) ) * 0.0089;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 7.0 * blurAmount ) ) * 0.0044;
	}
	else if( blurMethod == 1 )
	{
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 4.0 * blurAmount ) ) * 0.05;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 3.0 * blurAmount ) ) * 0.09;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 2.0 * blurAmount ) ) * 0.12;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 1.0 * blurAmount ) ) * 0.15;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y ) ) * 0.16;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 1.0 * blurAmount ) ) * 0.15;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 2.0 * blurAmount ) ) * 0.12;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 3.0 * blurAmount ) ) * 0.09;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 4.0 * blurAmount ) ) * 0.05;
	}
	else
	{
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 3.0 * blurAmount ) ) * 0.1;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 2.0 * blurAmount ) ) * 0.133;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y - 1.0 * blurAmount ) ) * 0.167;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y ) ) * 0.18;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 1.0 * blurAmount ) ) * 0.167;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 2.0 * blurAmount ) ) * 0.133;
		sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y + 3.0 * blurAmount ) ) * 0.1;
	}
				
	gl_FragColor = sum * v_fragmentColor;
}
