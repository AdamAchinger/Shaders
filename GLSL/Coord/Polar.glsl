void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // polar coordinate systems 
    vec2 uv = fragCoord / iResolution.xy;
    float PI = 3.141592;

    uv = uv - vec2(0.5,0.5);
    float r = distance(uv,vec2(0.0,0.0));
    float theta = (atan(uv.y,uv.x)+PI)/(PI*2.0);

    vec3 color = vec3(r,theta,0.0);

    fragColor = vec4(color, 1.0);
}   