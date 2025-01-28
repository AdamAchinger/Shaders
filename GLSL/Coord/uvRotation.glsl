void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    float dim = iResolution.y / iResolution.x;
    uv = vec2(uv.x, uv.y * dim);
    uv -= vec2(0.5,0.5);


    float time = iTime*0.2 ;

    float uvX = uv.x * cos(time) - uv.y * sin(time);
    float uvY = uv.x * sin(time) + uv.y * cos(time);
    uv = vec2(uvX,uvY);
 

    

    // CHECKER 
    vec2 uvCScale = vec2(100.0,100.0);
    float stripX =  step(sin(uv.x*uvCScale.x),0.0);
    float stripY =  step(sin(uv.y*uvCScale.y),0.0);
    float checkerA = stripX + stripY;
    float checkerB = max(stripX,stripY);
    float checkerC = floor(checkerA * 0.5);
    float checker = checkerB - checkerC;

    vec3 OUT = vec3(checker);
    
    fragColor = vec4(OUT, 1.0);
}