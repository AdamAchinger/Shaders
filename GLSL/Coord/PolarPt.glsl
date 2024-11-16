void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // polar coordinate systems     
    vec2 uv = fragCoord / iResolution.xy;
    float PI = 3.141592;

    uv = (uv - vec2(0.5,0.5))*2.0;


    vec2 pos = vec2(0.5,fract(iTime*0.25)); 

    vec2 posFp = vec2(pos.x*(cos(pos.y*PI*2.0)),pos.x*(sin(pos.y*PI*2.0)));

    float circle = step(distance(uv,posFp),0.02);



    // BG
    float r = distance(uv,vec2(0.0,0.0));
    float theta = (atan(uv.y,uv.x)+PI)/(PI*2.0);
    vec2 uvP = vec2(r,theta);

    vec3 color = mix(vec3(uvP,0.0),vec3(1.0,1.0,1.0),circle);

    fragColor = vec4(color, 1.0);
}   