void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;

    float seed = iTime;

    float randX = fract(sin(seed * 123142.12441) * 42148.5453123);
    float randY = fract(sin(seed * 912411.15027) * 63758.1937456);
    float randZ = fract(sin(seed * 144242.12441) * 13758.5492721);

    vec3 color = vec3(randX,randY,randZ); 
    fragColor = vec4(color, 1.0);
}