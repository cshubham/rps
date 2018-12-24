precision mediump float;

uniform float uColorInfluence;
uniform float uTime;
uniform float uInfluencemyTex;
uniform sampler2D myTex;

uniform float texelWidth;
uniform float texelHeight;

varying vec2 vTextureCoord;
varying vec4 vColor;

void main() {
	//vec4 color = uColorInfluence * vColor;
	vec4 texColor = texture2D(myTex, vTextureCoord);
	//texColor *= uInfluencemyTex;
	//color += texColor;
	//gl_FragColor = color;
	//vec3 a=vec3(texColor.x);
	//gl_FragColor=vec4(a,1.);
vec2 uv=vTextureCoord;
	vec2 bottom = uv - vec2(0.0, 5.0/texColor.y);
        vec2 top = uv + vec2(0.0, 2.0/texColor.y);
        vec2 left = uv - vec2(5.0/texColor.x, 0.0);
        vec2 right = uv + vec2(2.0/texColor.x, 0.0);
        vec4 glowColor = vec4(1.0, 0.0, 1.0, 1.0) ;

       vec4 fragColor = texColor;
       vec4 fragColorInput=texColor;
           // if (length(fragColorInput.rgb) < 0.1) {
         //  && ( length(texture(texColor, left).rgb) > 0.1 || length(texture(texColor, top).rgb) > 0.1 || length(texture(texColor, bottom).rgb) > 0.1 || length(texture(texColor, right).rgb) > 0.1)
           	if (length(fragColorInput.rgb) < 0.1 ) {
            fragColor = fragColorInput
        			+ glowColor * texture2D(texColor, left)
              	    + glowColor * texture2D(texColor, top)
               	    + glowColor * texture2D(texColor, right)
                	+  texture2D(texColor, bottom)
                    ;
            }

	gl_FragColor=fragColor;
}
