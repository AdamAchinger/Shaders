void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float dim = iResolution.y / iResolution.x;
    uv = vec2(uv.x, uv.y * dim);

    float uvScale = 11.0;

    vec2 n1 = floor(uv* uvScale)/uvScale;

    
    vec3 color = vec3(n1,0.0);
    fragColor = vec4(color, 1.0);
}



