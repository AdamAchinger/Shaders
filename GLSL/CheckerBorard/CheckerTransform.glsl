void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = fragCoord / iResolution.xy;

    vec2 uvScale = vec2(50.0,50.0);

    float uvX = uv.x + sin((uv.x*5.0)+iTime*0.1);
    float uvY = uv.y + sin((uv.y*5.0)+iTime*0.1);

    float stripX =  step(sin(uvX*uvScale.x),0.0);
    float stripY =  step(sin(uvY*uvScale.y),0.0);

    float checker = stripX + stripY;
    float checker3 = max(stripX,stripY);
    float checker1 = floor(checker * 0.5);
    float checker2 = checker3 - checker1;

    vec3 color = vec3(checker2);
    
    fragColor = vec4(color, 1.0);
}