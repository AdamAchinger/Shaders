void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // polar coordinate systems 
    vec2 uv = fragCoord / iResolution.xy;
    vec2 cent = vec2(0.5,0.5);
    float PI = 3.141592;

    float ang = iTime;
    float dotSize = 0.02;

    float uvPy = distance(uv,cent);

    vec2 uvP = vec2(uv.x,uvPy);
    vec2 pos = vec2(0.0,0.0);

    float ptMask = step(uvPy,dotSize);

    vec3 uvBG = vec3(uvPy,0,0);

    vec3 color = mix(uvBG,vec3(1,1,1),ptMask);
    
    

    fragColor = vec4(color, 1.0);
}   