void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = fragCoord / iResolution.xy;
    float dim = iResolution.y / iResolution.x ;
    vec2 uv2 = vec2(uv.x, uv.y * dim);
    vec2 mouse = vec2(iMouse.x, iMouse.y * iResolution.y / iResolution.x);

    float r = 0.1;
    float rSpeed = 4.0;
    vec3 hueColor = vec3(0.1216, 0.4588, 0.2824);
    
    float xPos = (cos(iTime*rSpeed+1.5) * r*2.0) + 0.5;
    float yPos = (sin(iTime*rSpeed+1.5) * r*2.0) +(0.5 * dim);
    vec2 pos = vec2(xPos,yPos);
    
    if(iMouse.z > 0.0){
        pos = mouse / iResolution.xy;
    }
    
    float xPos1 = (cos(1.0-iTime*rSpeed) * r) + 0.5;
    float yPos1 = (sin(1.0-iTime*rSpeed) * r) +(0.5 * dim);
    vec2 cent1 = vec2(xPos1,yPos1);
   
     
    float xPos2 = (cos(iTime*rSpeed*1.2) * r*1.5) + 0.5;
    float yPos2 = (sin(iTime*rSpeed*1.) * r*1.5) +(0.5 * dim);
    
    vec2 cent2 = vec2(xPos2,yPos2);
    
    
    float dist = distance(pos,cent1);
    float dist1 = distance(pos,cent2);
    float dist2 = distance(cent2,cent1);
    float averageDist = (dist+dist1+dist2) / 3.0;
    
    
    float dis = smoothstep(0.0005,distance(pos,uv2),0.025);
    float dis2 = smoothstep(0.0005,distance(cent1,uv2),0.025);
    float dis3 = smoothstep(0.0005,distance(cent2,uv2),0.025);
    

    float addF = 0.0;
    int steps = int(averageDist*100.0);
    
    for (int i = 0; i < steps; i++) {
        vec2 m = mix(pos,cent1,(float(i)/float(steps)));
        float dis3 = smoothstep(0.001,distance(m,uv2),0.005);
        vec2 m2 = mix(pos,cent2,(float(i)/float(steps)));
        float dis4 = smoothstep(0.001,distance(m2,uv2),0.005);
        vec2 m3 = mix(cent2,cent1,(float(i)/float(steps)));
        float dis5 = smoothstep(0.001,distance(m3,uv2),0.005);

        addF += dis3+dis4+dis5;
    }
   
    float add = dis+dis2+dis3+addF;
    
    
    // PostProcess 
    float redMask = max(max(max(dis,dis2),dis3),addF);
    vec3 redColor = hueColor * redMask;
    
    vec3 color = vec3(pow(add,5.0)) * 0.25;
    color += redColor * 0.5;
    
    fragColor = vec4(color, 1.0);
}