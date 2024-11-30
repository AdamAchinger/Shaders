void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float PI = 3.141592;

    vec2 uvScale = vec2(50.0,100.0);

    uv = uv - vec2(0.5,0.5);
    float r = distance(uv,vec2(0.0,0.0));
    float theta = (atan(uv.y,uv.x)+PI)/(PI*2.0);
    
    uv = vec2(r,theta);
    float time = fract(iTime*0.1);

    float splineMask = 0.0 ;
    float dotsMask = 0.0 ;

    // second 
    float secThick = ((r*-1.0 + 1.0) * 0.005 );
    float secondMask = smoothstep(secThick,0.0,distance(theta,0.2));

    for (float i = 0.0; i < 6.0; i++){
        float r1 = (r*6.0);
        float theta1 = theta*1.0 + (i-time) ;
        splineMask = max(smoothstep(0.02,0.0,distance(theta1,r1)), splineMask);
        
        vec2 dotPos = vec2(sin(theta1),cos(theta1)) * r1;
        dotPos += (i-time);

        
        dotsMask += step(distance(uv,dotPos),0.1);
        
    }

    // post process 
    splineMask = 1.0 - splineMask ;

    vec3 color = vec3(splineMask);
    
    fragColor = vec4(color, 1.0);
}