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
//// Sun
vec3 SUN( vec2 uv, vec2 uvP, vec2 cent, float PI,vec3 black, float time ){

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
        
        float rayTime = sin((iTime*0.015)*fRand(a));
        float ray = smoothstep(0.01,0.0,distance(uvP.y,a+rayTime));
        float rayDistTime = (sin(iTime*fRand(a))+PI)/(2.0/PI) *0.3;
        float rayDist = smoothstep(rayDistTime * sunSize ,0.0,uvP.x);

        distToAng += ray * rayDist ;
    }

    float sunRays = max(min(SunMaskSmooth * distToAng,1.0) - SunMaskSolid,0.0);
    float noiseScale = 64.0;
    noiseScale /= sunSize;
    float sunNoise = mix(noise(uv*noiseScale*0.4+vec2(time*0.25,0.0)),noise(uv*noiseScale+vec2(time*0.5,0.2)),(sin(iTime)+PI)/(2.0*PI));
    float SunMask1 =  min(sunRays + SunMaskSolid + (SunMaskSmooth*sunNoise*SunMaskSolid) + SunHalo1 + SunHalo2,3.0);
    
    SunMask1 -= (SunMaskSmooth*SunMaskSmooth) * SunMaskSolid;

    vec3 Sun = mix(mix(black,sunColor,SunMask1),sunAuraColor, SpaceAura);
    
    /// SUN END /// 
    return Sun;
}

//// Mercury
vec4 Mercury( vec2 uv, vec2 uvP, float PI, vec3 black, float time,vec3 sunGlowColor){
    vec3 mercColor = vec3(0.4941, 0.4941, 0.4941);
    float mercOrb = time*0.047*0.5;
    float mercSize = 0.0048;
    float mercDist = 0.057 * 2.0;
    float revUvPX = ((uvP.x*-1.0)+1.0);
    
    float angleTime = fract(mercOrb);
    vec2 MercPos = vec2(sin(angleTime*2.0*PI + PI),cos(angleTime*2.0*PI + PI))* mercDist;
    float MercMask = step(distance(uv,MercPos),mercSize);

    float ShadowAngle = smoothstep(mercSize*2.3,0.0,distance(uvP.y,angleTime));
    float ShadowDist = step(mercDist,uvP.x);   
    float Shadow = max((ShadowAngle * ShadowDist * pow(revUvPX,9.0)) - MercMask,0.0) ;

    float glowSize = 0.5;
    float innerRing = step(mercSize*glowSize,distance(uv,MercPos)); 
    float BrightSideMask =  MercMask * innerRing * (ShadowDist*-1.0+1.0);


    float venusNoise = max(noise((uv+MercPos*-1.0+1.0)*1000.0),0.4);

    vec3 Mercury = mix(mix(black,mercColor,MercMask)*venusNoise,sunGlowColor,BrightSideMask);
    
    vec4 OUT = vec4(Mercury,Shadow);
    return OUT;
}
//// Venus
vec4 Venus( vec2 uv, vec2 uvP, float PI, vec3 black, float time,vec3 sunGlowColor){
    vec3 venuColor = vec3(0.4039, 0.3333, 0.1137);
    float venuOrb = time*0.035*0.5;
    float venuSize = 0.012;
    float venuDist = 0.1 * 2.0;
    float revUvPX = ((uvP.x*-1.0)+1.0);
    
    float angleTime = fract(venuOrb);
    vec2 VenuPos = vec2(sin(angleTime*2.0*PI + PI),cos(angleTime*2.0*PI + PI))* venuDist;
    float VenuMask = step(distance(uv,VenuPos),venuSize);

    float ShadowAngle = smoothstep(venuSize*1.0,0.0,distance(uvP.y,angleTime));
    float ShadowDist = step(venuDist,uvP.x);   
    float Shadow = max((ShadowAngle * ShadowDist * pow(revUvPX,4.0)) - VenuMask,0.0);
    
    float glowSize = 0.7;
    float innerRing = step(venuSize*glowSize,distance(uv,VenuPos));
    float BrightSideMask =  VenuMask * innerRing * (ShadowDist*-1.0+1.0);

    float shadowinnerRing = smoothstep(0.1,0.0,distance(uv,VenuPos));
    float DarkSideMask =  VenuMask * shadowinnerRing * ShadowDist;

    Shadow = max(Shadow,DarkSideMask*0.3);

    float venusNoise = max(noise((uv+VenuPos*-1.0+1.0)*1000.0),0.4);

    vec3 Venus = mix(mix(black,venuColor,VenuMask)*venusNoise,sunGlowColor,BrightSideMask);

    vec4 OUT = vec4(Venus,Shadow);
    return OUT;
}


void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float dim = iResolution.y / iResolution.x;
    uv = vec2(uv.x, uv.y * dim);
    uv = uv - vec2(0.5,0.5);


    float PI = 3.14159265;
    vec2 cent = vec2(0.0,0.0);
    vec3 black = vec3(0.0,0.0,0.0);
    vec3 sunGlowColor = vec3(0.3529, 0.2549, 0.1569);
    float time = iTime ; 
    float angle = atan(uv.x,uv.y);
    float angleCap = (angle+PI)/(2.0*PI);
    float centDistR = distance(uv,cent);

    vec2 uvP = vec2(centDistR,angleCap);

    // Sun
    vec3 Sun = SUN(uv,uvP,cent,PI,black,time);

    //Mercury 
    vec4 MercuryPack = Mercury(uv,uvP,PI,black,time,sunGlowColor);

    vec3 Mercury = MercuryPack.xyz;
    float MercuryShadow = MercuryPack.w;
    
    //Venus
    vec4 VenusPack = Venus(uv,uvP,PI,black,time,sunGlowColor);

    vec3 Venus = VenusPack.xyz;
    float VenusShadow = VenusPack.w;


    // Comlite
    vec3 Celestial = Sun + Mercury + Venus; 

    float CelestialShadows = MercuryShadow + VenusShadow ; 

        CelestialShadows = CelestialShadows*-1.0 +1.0 ;
    Celestial *= CelestialShadows;


    //Post Process
    vec3 OUT = vec3(Celestial);


    fragColor = vec4(OUT, 1.0);
}
