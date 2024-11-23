void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = fragCoord / iResolution.xy;

    vec2 uvScale = vec2(50.0,50.0);

    float stripX =  step(sin(uv.x*uvScale.x),0.0);
    float stripY =  step(sin(uv.y*uvScale.y),0.0);


    float checker = stripX + stripY;
    float checker3 = max(stripX,stripY);
    float checker1 = floor(checker * 0.5);
    float checker2 = checker3 - checker1;

    vec3 color = vec3(checker2);
    
    fragColor = vec4(color, 1.0);
}