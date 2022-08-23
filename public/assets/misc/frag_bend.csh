#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
//uniform sampler2D CC_Texture0;
uniform float timeTotal;

// const float bendFactor = 0.05;	// aaltoilun määrä
const float bendFactor = 0.02;	// aaltoilun määrä

void main()
{
	float waveOffset = sin( timeTotal + v_texCoord.x / 58.0 * 360.0 ) * bendFactor;	

	float xOffset = -timeTotal / 10.0;	// sivuttaisliikkuminen, nää nolliksi niin ei liiku mihinkään
	float yOffset = -timeTotal / 22.0;	// pystyliike, nää nolliksi niin ei liiku mihinkään
	
	vec4 normalColor = texture2D( CC_Texture0, fract( vec2( v_texCoord.x + xOffset, v_texCoord.y + waveOffset + yOffset ) ) );
	gl_FragColor = vec4( normalColor );


	// testiä
	//gl_FragColor = texture2D( CC_Texture0, v_texCoord );
}
