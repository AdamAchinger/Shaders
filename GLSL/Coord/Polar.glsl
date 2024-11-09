void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // polar coordinate systems 
    vec2 uv = fragCoord / iResolution.xy;

    uv = uv - vec2(0.5,0.5);

    float theta = sin(uv.y);
    
    float r = distance(uv,vec2(0.0,0.0));
    vec2 polar = vec2(r,theta);

    vec2 Pos = vec2(0.1,0.0);
    
    float dist = step(distance(polar,Pos),0.0);

    vec3 color = vec3(dist);
    fragColor = vec4(color, 1.0);
}   