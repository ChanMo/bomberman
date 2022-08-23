#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
varying vec4 v_fragmentColor;
uniform sampler2D CC_Texture0;

uniform vec2 blurSize;

void main()
{
	float blurAmountX = blurSize.x * 1.0;
	float blurAmountY = blurSize.y * 1.0;

	vec4 sum = vec4( 0.0 );
		
	sum += texture2D( CC_Texture0, vec2( v_texCoord.x - 4.0 * blurAmountX, v_texCoord.y - 4.0 * blurAmountY ) ) * 0.05;
	sum += texture2D( CC_Texture0, vec2( v_texCoord.x - 3.0 * blurAmountX, v_texCoord.y - 3.0 * blurAmountY ) ) * 0.09;
	sum += texture2D( CC_Texture0, vec2( v_texCoord.x - 2.0 * blurAmountX, v_texCoord.y - 2.0 * blurAmountY ) ) * 0.12;
	sum += texture2D( CC_Texture0, vec2( v_texCoord.x - 1.0 * blurAmountX, v_texCoord.y - 1.0 * blurAmountY ) ) * 0.15;
	sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y ) ) * 0.16;
	sum += texture2D( CC_Texture0, vec2( v_texCoord.x + 1.0 * blurAmountX, v_texCoord.y + 1.0 * blurAmountY ) ) * 0.15;
	sum += texture2D( CC_Texture0, vec2( v_texCoord.x + 2.0 * blurAmountX, v_texCoord.y + 2.0 * blurAmountY ) ) * 0.12;
	sum += texture2D( CC_Texture0, vec2( v_texCoord.x + 3.0 * blurAmountX, v_texCoord.y + 3.0 * blurAmountY ) ) * 0.09;
	sum += texture2D( CC_Texture0, vec2( v_texCoord.x + 4.0 * blurAmountX, v_texCoord.y + 4.0 * blurAmountY ) ) * 0.05;
		
	gl_FragColor = sum * v_fragmentColor;
	
	// high def blur
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x - 7.0 * blurAmountX, v_texCoord.y - 7.0 * blurAmountY ) ) * 0.0044;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x - 6.0 * blurAmountX, v_texCoord.y - 6.0 * blurAmountY ) ) * 0.0089;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x - 5.0 * blurAmountX, v_texCoord.y - 5.0 * blurAmountY ) ) * 0.0215;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x - 4.0 * blurAmountX, v_texCoord.y - 4.0 * blurAmountY ) ) * 0.0443;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x - 3.0 * blurAmountX, v_texCoord.y - 3.0 * blurAmountY ) ) * 0.0776;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x - 2.0 * blurAmountX, v_texCoord.y - 2.0 * blurAmountY ) ) * 0.1158;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x - 1.0 * blurAmountX, v_texCoord.y - 1.0 * blurAmountY ) ) * 0.1473;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x, v_texCoord.y ) ) * 0.1595;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x + 1.0 * blurAmountX, v_texCoord.y + 1.0 * blurAmountY ) ) * 0.1473;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x + 2.0 * blurAmountX, v_texCoord.y + 2.0 * blurAmountY ) ) * 0.1158;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x + 3.0 * blurAmountX, v_texCoord.y + 3.0 * blurAmountY ) ) * 0.0776;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x + 4.0 * blurAmountX, v_texCoord.y + 4.0 * blurAmountY ) ) * 0.0443;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x + 5.0 * blurAmountX, v_texCoord.y + 5.0 * blurAmountY ) ) * 0.0215;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x + 6.0 * blurAmountX, v_texCoord.y + 6.0 * blurAmountY ) ) * 0.0089;
	// sum += texture2D( CC_Texture0, vec2( v_texCoord.x + 7.0 * blurAmountX, v_texCoord.y + 7.0 * blurAmountY ) ) * 0.0044;
					
	//gl_FragColor = sum * v_fragmentColor;
}
