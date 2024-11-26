vec2 fade(vec2 t) {
    return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}

float perlinNoise(vec2 P) {
    vec4 Pi = floor(P.xyxy);
    vec4 Pf = fract(P.xyxy);
    Pi = mod(Pi, 289.0); // aby uniknąć efektów przycinania
    vec4 ix = Pi.xzxz;
    vec4 iy = Pi.yyww;
    vec4 fx = Pf.xzxz;
    vec4 fy = Pf.yyww;

    // Interpolacja
    float a = dot(rand(ix), fx.x);
    float b = dot(rand(ix + 1.0), fx.y);
    float c = dot(rand(ix + 1.0), fy.x);
    float d = dot(rand(ix + 1.0), fy.y);

    return mix(mix(a, b, fade(fx.y)), mix(c, d, fade(fx.y)), fade(fx.x));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float dim = iResolution.y / iResolution.x;
    uv = vec2(uv.x, uv.y * dim);

    float uvScale = 11.0;

    vec2 n1 = floor(uv* uvScale)/uvScale;

    
    vec3 color = vec3(n1,0.0);
    fragColor = vec4(color, 1.0);
}



