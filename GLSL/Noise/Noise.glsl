void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float dim = iResolution.y / iResolution.x;
    uv = vec2(uv.x, uv.y * dim);

    vec2 n1 = fract(uv* 4.0);

    vec2 n2 = fract((uv* 9.120) + 18.34);

    vec2 m = mix(n1,n2,0.5);
    float k = step(distance(n1,n2),0.5);
    
    vec3 color = vec3(k);
    fragColor = vec4(color, 1.0);
}



