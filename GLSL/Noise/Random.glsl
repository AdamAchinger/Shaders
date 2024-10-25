void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // random noise
    vec2 uv = fragCoord / iResolution.xy;


    float seed = 1.1;

    float rand = fract(sin(dot(uv,vec2(12.9898,78.233*seed))) * 43758.5453 + seed);


    vec3 color = vec3(rand,0,0);
    fragColor = vec4(color, 1.0);
}   