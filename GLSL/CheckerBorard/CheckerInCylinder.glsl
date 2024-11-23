void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float PI = 3.141592;

    vec2 uvScale = vec2(50.0,100.0);

    uv = uv - vec2(0.5,0.5);
    float r = distance(uv,vec2(0.0,0.0));
    float theta = (atan(uv.y,uv.x)+PI)/(PI*2.0);
    
    uv =vec2(r,theta);


    float stripX =  step(sin(uv.x*uvScale.x+iTime),0.0);
    float stripY =  step(sin(uv.y*uvScale.y+iTime),0.0);


    float checker = stripX + stripY;
    float checker3 = max(stripX,stripY);
    float checker1 = floor(checker * 0.5);
    float checker2 = checker3 - checker1;

    vec3 color = vec3(checker2);
    
    fragColor = vec4(color, 1.0);
}