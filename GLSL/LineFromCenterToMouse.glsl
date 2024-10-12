void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = fragCoord / iResolution.xy;
    
    vec2 uv2 = vec2(uv.x, uv.y * iResolution.y / iResolution.x);
    vec2 mouse = vec2(iMouse.x, iMouse.y * iResolution.y / iResolution.x);
    
    vec2 pos = mouse / iResolution.xy;
    vec2 cent = vec2(0.5,0.25);
    
    float dist = distance(pos,cent);
    
    float dis = step(distance(pos,uv2),0.025);
    float dis2 = step(distance(cent,uv2),0.025);
    
    
    
    float addF = 0.0;
    int steps = int(dist*30.0);
    
    for (int i = 0; i < steps; i++) {
        vec2 m = mix(pos,cent,(float(i)/float(steps)));
        
        float dis3 = step(distance(m,uv2),0.02);
        addF += dis3;
    }
   
    float add = dis+dis2+addF;
    
    vec3 color = vec3(add);
    
    fragColor = vec4(color, 1.0);
}
