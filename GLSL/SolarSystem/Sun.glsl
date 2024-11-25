
void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float dim = iResolution.y / iResolution.x;
    uv = vec2(uv.x, uv.y * dim);

    float PI = 3.14159265;
    vec2 cent = vec2(0.0,0.0);
    vec3 black = vec3(0.0,0.0,0.0);
    float time = iTime; 

    //PolarCord
    uv = uv - vec2(0.5,0.8);

    //Sun 
    vec3 sunColor = vec3(0.9961, 0.3882, 0.1882);
    vec3 sunAuraColor = vec3(0.8706, 0.6706, 0.4706);
    float sunSize = 0.5;
    float SunMaskSolid = step(distance(uv,cent),sunSize*0.6);
    float SunMask = smoothstep(sunSize,0.0,distance(uv,cent));
    SunMask += SunMaskSolid;
    float SpaceAura = smoothstep(1.0,0.0,distance(uv,cent)) * 0.2;
    vec3 Sun = mix(mix(black,sunColor,SunMask),sunAuraColor, SpaceAura);



    //Post Process
    vec3 OUT = vec3(Sun)  ;

    vec3 color = OUT;
    fragColor = vec4(color, 1.0);
}



