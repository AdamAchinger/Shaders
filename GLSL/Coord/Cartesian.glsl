void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // cartesian coordinate systems 
    vec2 uv = fragCoord / iResolution.xy;
    vec2 cent = vec2(0.0,0.0);
    vec3 color = vec3(uv.x,uv.y,0);
    fragColor = vec4(color, 1.0);
}