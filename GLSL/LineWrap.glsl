void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord / iResolution.xy;
    uv = uv - vec2(0.5,0.5);

    float PI = 3.141592;

    float r = distance(uv,vec2(0.0,0.0));
    float theta = (atan(uv.y,uv.x)+PI)/(PI*2.0);
    vec2 uvP = vec2(r,theta);


    vec2 p1 = vec2(-0.1,-0.2);
    vec2 p2 = vec2(0.1,0.2);
    
    float ptDits = distance(p1,p2);
    float uv1Dist = distance(p1,uv) / ptDits;
    float uv2Dist = distance(p2,uv) / ptDits;
    float lineMask = sin(smoothstep(0.5,0.0,distance(uv1Dist,1.0-uv2Dist))*50.0);
    
     

    float pt1Mask = smoothstep(0.01,0.006,distance(uv,p1));
    float pt2Mask = smoothstep(0.01,0.006,distance(uv,p2));
    float ptsMask = max(pt1Mask,pt2Mask);

    float x = ptsMask + lineMask;

    vec3 OUT = vec3(x);

    fragColor = vec4(OUT, 1.0);
}   