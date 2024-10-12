void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = fragCoord / iResolution.xy;
    
    vec2 uv2 = vec2(uv.x, uv.y * iResolution.y / iResolution.x);
    vec2 mouse = vec2(iMouse.x, iMouse.y * iResolution.y / iResolution.x);
    
    vec2 pos = mouse / iResolution.xy;


    vec3 red = vec3(1.0, 0.0, 0.0);
    
    float dis = step(distance(pos,uv2),0.05);


    vec3 color = vec3(dis,dis,dis);
    
    fragColor = vec4(color, 1.0);
}
