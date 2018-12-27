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
/*	//vec4 color = uColorInfluence * vColor;
	vec4 texColor = texture2D(myTex, vTextureCoord);
	//texColor *= uInfluencemyTex;
	//color += texColor;
	//gl_FragColor = color;
	//vec3 a=vec3(texColor.x);
	//gl_FragColor=vec4(a,1.);
vec2 uv=vTextureCoord;
	vec2 bottom = uv - vec2(0.0, 5.0/texelHeight);
        vec2 top = uv + vec2(0.0, 2.0/texelHeight);
        vec2 left = uv - vec2(5.0/texelWidth, 0.0);
        vec2 right = uv + vec2(2.0/texelWidth, 0.0);
        vec4 glowColor = vec4(1.0, 0.0, 1.0, 1.0) ;

       vec4 fragColor = texColor;
       //vec4 fragColorInput=texColor;
           // if (length(fragColorInput.rgb) < 0.1 ) {
         //  && ( length(texture(texColor, left).rgb) > 0.1 || length(texture(texColor, top).rgb) > 0.1 || length(texture(texColor, bottom).rgb) > 0.1 || length(texture(texColor, right).rgb) > 0.1)
           	if (length(texColor.rgb) < 0.1 ) {
            fragColor = texColor
        			+ glowColor * texture2D(myTex, left)
              	    + glowColor * texture2D(myTex, top)
               	    + glowColor * texture2D(myTex, right)
                	+  texture2D(myTex, bottom)
                    ;
            }

	gl_FragColor=fragColor;*/

	 vec2 uv=vTextureCoord;

        //vec4 fragColorInput = texture(myTex, uv);
        vec4 texColor = texture2D(myTex, vTextureCoord);

        gl_FragColor = vec4(0.0,0.0,0.0,1.0);
        //fragColor = vec4(col,col,col,1.0);
        float x_fix = 1.0/texelWidth;
        float y_fix = 1.0/texelHeight;
        float x_var = x_fix;
        float y_var = y_fix;

        for(int i=0;i<8;i++){
            vec2 bottom = uv - vec2(0.0, y_var);
            vec2 top = uv + vec2(0.0, y_var);
            vec2 left = uv - vec2(x_var, 0.0);
            vec2 right = uv + vec2(x_var, 0.0);
            vec2 topLeft = uv + vec2(-x_var, y_var);
            vec2 topRight = uv + vec2(x_var, y_var);
            vec2 bottomLeft = uv + vec2(-x_var, -y_var);
            vec2 bottomRight = uv + vec2(x_var, -y_var);

            float mRGB = length(texColor.rgb);
            float lRGB = length(texture2D(myTex,left).rgb);
            float rRGB = length(texture2D(myTex,right).rgb);
            float tRGB = length(texture2D(myTex,top).rgb);
            float bRGB = length(texture2D(myTex,bottom).rgb);
           // gl_FragColor = texColor;
            float a = 100.0;
            float b;
            int flag = 0;
            for(int j =0;j<1;j++){
                if(length(texture2D(myTex,uv).rgb) == 0.0){
                    if(lRGB != 0.0 ){
                        flag=1;
                        a = min(a , lRGB);
                    }
                    if(rRGB != 0.0 ){
                        flag=1;
                        a = min(a , rRGB);
                    }
                    if(tRGB != 0.0 ){
                        flag=1;
                        a = min(a , tRGB);
                    }
                    if(bRGB != 0.0 ){
                        flag=1;
                        a = min(a , bRGB);
                    }
                    if(length(texture2D(myTex,topLeft).rgb) != 0.0 ){
                        flag=1;
                        a = min(a, 1.41 * length(texture2D(myTex,topLeft).rgb));
                    }
                    if(length(texture2D(myTex,topRight).rgb) != 0.0 ){
                        flag=1;
                        a = min(a,1.41 * length(texture2D(myTex,topRight).rgb));
                    }
                    if(length(texture2D(myTex,bottomLeft).rgb) != 0.0 ){
                        flag=1;
                        a = min(a,1.41 * length(texture2D(myTex,bottomLeft).rgb));
                    }
                    if(length(texture2D(myTex,bottomRight).rgb) != 0.0 ){
                        flag=1;
                        a = min(a,1.41 * length(texture2D(myTex,bottomRight).rgb));
                    }
                    //a=1.0;
                    if(flag == 0)
                        a=0.0;
                      //  b=4. * a;

                    a = fract(a) * length(vec2(x_var,y_var));
                    b=10. * a;
                    gl_FragColor += vec4(0.95*(0.1 * (b/1.0) + 0.1* mod(b,1.0)),0.2 * (b/1.0) + 0.1 * mod(b,1.0), 0.95*(0.1 *(b/1.0) + 0.1 * mod(b,1.0)),1.0);
                  //  gl_FragColor += vec4(20.0 * 0.45*a,20.0*a,20.0*0.95*a,1.0);
                }
            }
            y_var+=y_fix;
            x_var+=x_fix;

        }


	//gl_FragColor=fragColor;









}
