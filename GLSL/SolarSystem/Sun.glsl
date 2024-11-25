//// Fcunctions

float fRand(float seed){
    float rand1 = fract(sin(seed*185.125) *3375.5453 + seed);
    return rand1;
}


//// Main 
void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float dim = iResolution.y / iResolution.x;
    uv = vec2(uv.x, uv.y * dim);

    float PI = 3.14159265;
    vec2 cent = vec2(0.0,0.0);
    vec3 black = vec3(0.0,0.0,0.0);
    float time = iTime; 

    //PolarCord
    uv = uv - vec2(0.5,0.5);

    float centDistR = distance(uv,cent);
    float angle = (atan(uv.x,uv.y)+PI)/(2.0*PI);

    //Sun 
    vec3 sunColor = vec3(0.8706, 0.298, 0.1098);
    vec3 sunAuraColor = vec3(0.6745, 0.4667, 0.2588);
    float sunSize = 0.3;
    float SunMaskSolid = step(distance(uv,cent),sunSize*0.6);

    float SunMaskSmooth = smoothstep(sunSize,0.0,distance(uv,cent));


    float SpaceAura = smoothstep(1.0,0.0,distance(uv,cent)) * 0.2;
    float SunHalo1 = smoothstep(0.1*sunSize,0.0,distance(distance(uv,cent),sunSize*0.6));
    float SunHalo2 = smoothstep(0.05*sunSize,0.00,distance(distance(uv,cent),sunSize*0.6))*1.6;

    //Rays 
    
    float distToAng = 0.0;
    float iter = 340.0 ;
    for(float i=0.0; i<iter; i++){
        float a = i/iter;       
        
        float rayTime = sin(iTime*0.01*fRand(a));
        float ray = smoothstep(0.01,0.0,distance(angle,a+rayTime));
        float rayDistTime = (sin(iTime*fRand(a))+PI)/(2.0/PI) *0.3;
        float rayDist = smoothstep(rayDistTime * sunSize ,0.0,centDistR);

        distToAng += ray * rayDist ;
    }

    float sunRays = max(min(SunMaskSmooth * distToAng,1.0) - SunMaskSolid,0.0);

    float SunMask1 =  min(sunRays + SunMaskSolid + SunMaskSmooth + SunHalo1 + SunHalo2,3.1);
    vec3 Sun = mix(mix(black,sunColor,SunMask1),sunAuraColor, SpaceAura);



    //Post Proces
    vec3 OUT = vec3(Sun);

    vec3 color = OUT;
    fragColor = vec4(color, 1.0);
}



