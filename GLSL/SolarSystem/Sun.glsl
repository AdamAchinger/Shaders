//// Fcunctions

float fRand(float seed){
    float rand1 = fract(sin(seed*185.125) *3375.5453 + seed);
    return rand1;
}

float vRand(vec2 n) {
    return fract(sin(dot(n, vec2(12.924, 78.233))) * 43758.5453123);
}

float noise(vec2 n) {
    vec2 b = floor(n);
    vec2 f = smoothstep(vec2(0.0), vec2(1.0), fract(n));
    
    // Losowe wartości na wierzchołkach
    float v1 = vRand(b);
    float v2 = vRand(b + vec2(1.0, 0.0));
    float v3 = vRand(b + vec2(0.0, 1.0));
    float v4 = vRand(b + vec2(1.0, 1.0));
    
    // Interpolacja
    float i1 = mix(v1, v2, f.x);
    float i2 = mix(v3, v4, f.x);
    return mix(i1, i2, f.y);
}

vec3 SUN(float PI, vec2 uv, vec2 cent, vec3 black, float time){
    
    //PolarCord
    uv = uv - vec2(0.5,0.5);

    float centDistR = distance(uv,cent);
    float angle = (atan(uv.x,uv.y)+PI)/(2.0*PI);

//Sun 
    vec3 sunColor = vec3(0.8706, 0.298, 0.1098);
    vec3 sunAuraColor = vec3(0.6725, 0.4617, 0.2588);
    float sunSize = 0.1;
    float SunMaskSolid = step(distance(uv,cent),sunSize*0.6);

    float SunMaskSmooth = smoothstep(sunSize,0.0,distance(uv,cent));

    float SpaceAura = smoothstep(1.0,0.0,distance(uv,cent)) * 0.2;
    float SunHalo1 = smoothstep(0.1*sunSize,0.0,distance(distance(uv,cent),sunSize*0.6))*0.8;
    float SunHalo2 = smoothstep(0.03*sunSize,0.00,distance(distance(uv,cent),sunSize*0.6))*0.8;

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
    float noiseScale = 44.09;
    noiseScale /= sunSize;
    float sunNoise = mix(noise(uv*noiseScale*0.4+vec2(time*0.25,0.0)),noise(uv*noiseScale+vec2(time*0.5,0.2)),(sin(iTime)+PI)/(2.0*PI));
    float SunMask1 =  min(sunRays + SunMaskSolid + (SunMaskSmooth*sunNoise*SunMaskSolid) + SunHalo1 + SunHalo2,3.0);
    
    SunMask1 -= (SunMaskSmooth*SunMaskSmooth) * SunMaskSolid;

    vec3 Sun = mix(mix(black,sunColor,SunMask1),sunAuraColor, SpaceAura);
    
    /// SUN END /// 
    return Sun;
}

//// Main 
void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float dim = iResolution.y / iResolution.x;
    uv = vec2(uv.x, uv.y * dim);

    float PI = 3.14159265;
    vec2 cent = vec2(0.0,0.0);
    vec3 black = vec3(0.0, 0.0, 0.0);

    float time = iTime; 


//Sun 
    vec3 Sun = SUN(PI,uv,cent,black,time);

    
    //Post Proces
    vec3 OUT = vec3(Sun);
    
    fragColor = vec4(OUT, 1.0);
}



