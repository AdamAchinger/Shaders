void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    vec2 uv = fragCoord / iResolution.xy;
    float PI = 3.141592;
    vec2 cent = vec2(0.0,0.0);

    //PolarCord
    uv = uv - vec2(0.5,0.5);
    float r = distance(uv,cent);
    float theta = atan(uv.y,uv.x);
    float t = sin(theta*1.0+iTime*0.5);
    theta += t ;
    vec2 uvP = vec2(r,theta);

    //Checker
    vec2 uvScale = vec2(20.0,20.0);
    float revRadius = ((r*-1.0)+1.4);
    float distScale = revRadius*5.0; 
    float stripX = step(sin(uvP.x*(uvScale.x*distScale)),0.0);
    float stripY = step(sin(uvP.y*uvScale.y+iTime),0.0);

    float checker0 = stripX + stripY;
    float checker3 = max(stripX,stripY);
    float checker1 = floor(checker0 * 0.5);
    float checker2 = checker3 - checker1;

    //CenterDot
    float cenDot = smoothstep(0.001,0.03,distance(uv,cent));

    //Post Process
    float Bright = sin(r*5.0);
    float OUT = checker2* Bright* cenDot;




    vec3 color = vec3(OUT);
    
    fragColor = vec4(color, 1.0);
}