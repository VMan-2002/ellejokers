extern sampler2D palette;
extern vec2 paletteSize;
extern vec2 dims;

float bayer(vec2 pos) { 
	int x = int(mod(pos.x, 8.0));
	int y = int(mod(pos.y, 8.0));
	int index = y * 8 + x;
	
    float bayer[64];
    bayer[ 0] =  0.; bayer[ 1] = 48.; bayer[ 2] = 12.; bayer[ 3] = 60.; bayer[ 4] =  3.; bayer[ 5] = 51.; bayer[ 6] = 15.; bayer[ 7] = 63.;
	bayer[ 8] = 32.; bayer[ 9] = 16.; bayer[10] = 44.; bayer[11] = 28.; bayer[12] = 35.; bayer[13] = 19.; bayer[14] = 47.; bayer[15] = 31.;
	bayer[16] =  8.; bayer[17] = 56.; bayer[18] =  4.; bayer[19] = 52.; bayer[20] = 11.; bayer[21] = 59.; bayer[22] =  7.; bayer[23] = 55.;
	bayer[24] = 40.; bayer[25] = 24.; bayer[26] = 36.; bayer[27] = 20.; bayer[28] = 43.; bayer[29] = 27.; bayer[30] = 39.; bayer[31] = 23.;
	bayer[32] =  2.; bayer[33] = 50.; bayer[34] = 14.; bayer[35] = 62.; bayer[36] =  1.; bayer[37] = 49.; bayer[38] = 13.; bayer[39] = 61.;
	bayer[40] = 34.; bayer[41] = 18.; bayer[42] = 46.; bayer[43] = 30.; bayer[44] = 33.; bayer[45] = 17.; bayer[46] = 45.; bayer[47] = 29.;
	bayer[48] = 10.; bayer[49] = 58.; bayer[50] =  6.; bayer[51] = 54.; bayer[52] =  9.; bayer[53] = 57.; bayer[54] =  5.; bayer[55] = 53.;
	bayer[56] = 42.; bayer[57] = 26.; bayer[58] = 38.; bayer[59] = 22.; bayer[60] = 41.; bayer[61] = 25.; bayer[62] = 37.; bayer[63] = 21.;
	
	float threshold = bayer[index];
	return (threshold + 0.5) / 64.0;
}

float perceptualDist(vec3 a, vec3 b) {
    vec3 dif = a - b;
    return dot(dif * dif, vec3(0.299, 0.587, 0.114));
}

vec4 paletteFix(vec4 tex, vec2 uv, vec2 dims) {
	// The found colours' UV coordinates 
	vec2 target = vec2(0.0,0.0);
	vec2 target2 = vec2(0.0,0.0);
	
	// The found colours' distances from the original colour. Should not exceed ~1.44 normally.
	float targdist = 2.0;
	float targdist2 = 2.0;
	
	// Iterate through each pixel in the palette sprite (each colour)
	for (float i = 0.0; i < paletteSize.x*paletteSize.y; i++) {
		// Get the texture coordinates for the current palette colour with 0-1 range
		vec2 palCoord = vec2( mod( i, paletteSize.x ), floor( i / paletteSize.x ) ) / paletteSize;
		palCoord += vec2(.5,.5) / paletteSize; // Center UV coordinates on middle of pixels to prevent floating point imprecision
		
		// The palette colour being compared against
		vec3 comp = texture2D( palette, palCoord ).rgb;
		
		// Distance between the palette colour and the input colour
		float dist = perceptualDist(tex.rgb,comp);
		
		// I'm using ternary operators here because apparently if statements are more taxing on the GPU
		// Secondary colour is handled first to prevent weird logic shenanigans :p
		
		// Secondary colour
		target2 = dist < targdist ? target : (dist < targdist2 ? palCoord : target2);
		targdist2 = dist < targdist ? targdist : (dist < targdist2 ? dist : targdist2);
		
		// Main colour
		target = dist < targdist ? palCoord : target;
		targdist = dist < targdist ? dist : targdist;
	}
	
	float factor = targdist/(targdist + targdist2);
	
	vec2 cCoords = factor > bayer(dims) ? target2 : target;
	
	return vec4(texture2D( palette, cCoords ).rgb,tex.a);	
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
	vec4 tex = Texel(texture, floor(texture_coords*dims+.5)/dims);
	tex = paletteFix(tex,screen_coords,texture_coords*dims+.5);
	return tex;
}

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif