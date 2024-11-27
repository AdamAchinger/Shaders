float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 78.233))) * 43758.5453123);
}

float noise(vec2 n) {
    vec2 b = floor(n);
    vec2 f = smoothstep(vec2(0.0), vec2(1.0), fract(n));
    
    // Losowe wartości na wierzchołkach
    float v1 = rand(b);
    float v2 = rand(b + vec2(1.0, 0.0));
    float v3 = rand(b + vec2(0.0, 1.0));
    float v4 = rand(b + vec2(1.0, 1.0));
    
    // Interpolacja
    float i1 = mix(v1, v2, f.x);
    float i2 = mix(v3, v4, f.x);
    return mix(i1, i2, f.y);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float dim = iResolution.y / iResolution.x;
    uv = vec2(uv.x, uv.y * dim);
    uv -= vec2(0.5,0.5);

    vec2 cent = vec2(0.0,0.0);

    float uvScale = 42.43; 
    uv *= uvScale;

    vec2 uvDis = uv * distance(uv,cent) * 1.0;

    // grid for vis
    float gridX = mod(floor(uvDis.x),2.0);
    float gridY = mod(floor(uvDis.y),2.0);
    float grid = (gridX + gridY) - ((gridX * gridY)*2.0);


    float noi = noise(uv);

    vec3 OUT = vec3(noi);
    fragColor = vec4(OUT, 1.0);
}



