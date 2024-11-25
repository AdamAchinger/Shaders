void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float PI = 3.14159265;
    vec2 cent = vec2(0.0,0.0);
    vec3 black = vec3(0.0,0.0,0.0);
    float time = iTime; 

    //PolarCord
    uv = uv - vec2(0.5,0.5);
    float r = distance(uv,cent);
    float theta = (atan(uv.y,uv.x)+PI)/(PI*2.0);
    vec2 uvP = vec2(r,theta);

    //Sun 
    vec3 sunColor = vec3(0.9882, 0.4902, 0.3255);
    vec3 sunAuraColor = vec3(0.8706, 0.6706, 0.4706);
    float sunSize = 0.05;
    float SunMaskSolid = step(distance(uv,cent),sunSize*0.6);
    float SunMask = smoothstep(sunSize,0.0,distance(uv,cent));
    SunMask += SunMaskSolid;
    float SpaceAura = smoothstep(1.0,0.0,distance(uv,cent)) * 0.2;
    vec3 Sun = mix(mix(black,sunColor,SunMask),sunAuraColor, SpaceAura);


    //Mercury 
    vec3 mercColor = vec3(0.6275, 0.6235, 0.6235);
    float mercOrb = time * 1.5;
    float mercSize = 0.003;
    float mercDist = 0.06;

    vec2 MercPos = vec2(mercDist*sin(mercOrb),mercDist*cos(mercOrb));
    float MercMask = step(distance(uv,MercPos),mercSize);
    vec3 Mercury = mix(black,mercColor,MercMask);


    //Post Process
    vec3 OUT = vec3(Sun)  ;

    vec3 color = OUT;
    fragColor = vec4(color, 1.0);
}




    /*
    //Venus 
    vec3 venuColor = vec3(0.4627, 0.1451, 0.0);
    float venuOrb = time * 2.0;
    float venuSize = 0.007;
    float venuDist = 0.07;

    vec2 VenuPos = vec2(venuDist*sin(venuOrb),venuDist*cos(venuOrb));
    float VenuMask = step(distance(uv,VenuPos),venuSize);
    vec3 Venus = mix(black,venuColor,VenuMask);

    //Terra
    vec3 terrColor = vec3(0.0, 0.2549, 0.0824);
    float terrOrb = time * 0.25;
    float terrSize = 0.01;
    float terrDist = 0.15;

    vec2 TerrPos = vec2(terrDist*sin(terrOrb),terrDist*cos(terrOrb));
    float TerrMask = step(distance(uv,TerrPos),terrSize);
    vec3 Terra = mix(black,terrColor,TerrMask);


    //Mars
    vec3 marsColor = vec3(0.4824, 0.3137, 0.0745);
    float marsOrb = time * 0.2;
    float marsSize = 0.005;
    float marsDist = 0.25;

    vec2 MarsPos = vec2(marsDist*sin(marsOrb),marsDist*cos(marsOrb));
    float MarsMask = step(distance(uv,MarsPos),marsSize);
    vec3 Mars = mix(black,marsColor,MarsMask);


    //Jupiter 
    vec3 jupiColor = vec3(0.5725, 0.4549, 0.2902);
    float jupiOrb = time * 0.1;
    float jupiSize = 0.015;
    float jupiDist = 0.3;

    vec2 JupiPos = vec2(jupiDist*sin(jupiOrb),jupiDist*cos(jupiOrb));
    float JupiMask = step(distance(uv,JupiPos),jupiSize);
    vec3 Jupiter = mix(black,jupiColor,JupiMask);


    //Saturn  
    vec3 satuColor = vec3(0.2118, 0.1216, 0.0353);
    float satuOrb = time * 0.07;
    float satuSize = 0.01;
    float satuDist = 0.4;

    vec2 SatuPos = vec2(satuDist*sin(satuOrb),satuDist*cos(satuOrb));
    float SatuMask = step(distance(uv,SatuPos),satuSize);
    vec3 Saturn = mix(black,satuColor,SatuMask);
    */