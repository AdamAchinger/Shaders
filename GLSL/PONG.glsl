
int dirSwitch = 0;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord / iResolution.xy;
    uv = uv - vec2(0.5,0.5);
    float dim = iResolution.y / iResolution.x;
    uv = vec2(uv.x,uv.y*dim);
    

    float rightRect = 0.0 ;


    float mousePosY = (iMouse.y / iResolution.y) -0.5 ; 

    
    vec2 leftRectPos = vec2(-0.45,mousePosY);
    float leftRectWidth = 0.005;
    float leftRectHeight = 0.04;
    float leftRectDistVer = step(distance(uv.x,leftRectPos.x),leftRectWidth);
    float leftRectDistHor = step(distance(uv.y,leftRectPos.y),leftRectHeight);
    float leftRect = leftRectDistVer * leftRectDistHor;

    float t = (iTime*0.5);
    float tH = fract(t);
    float itH = tH*-1.0+1.0;
    float horiz = 0.0;


    vec3 objColor = vec3(0.0, 0.0, 0.0);

    float distTRS = 0.03;
    if(dirSwitch == 0){
        horiz = tH + leftRectPos.x*2.0 + distTRS ; 
        objColor = vec3(1.0, 1.0, 1.0);
    }else{
        horiz = tH + leftRectPos.x*2.0 + distTRS ;
        objColor = vec3(1.0, 0.0, 0.0);
    }


    float tV = fract(t);
    vec2 pongPos = vec2(horiz,tV);
    float LeftRectDistToPong = distance(pongPos,leftRectPos);
    if(LeftRectDistToPong < distTRS){
        dirSwitch = 1; 
    }else{
        dirSwitch = 0;
    }


    float pongSize = 0.01;
    float pong = step(distance(uv,pongPos),pongSize);
    float OBJs = leftRect + rightRect + pong; 

    vec3 BG = vec3(0.15);
    vec3 OUT = mix(BG,objColor,OBJs);


    fragColor = vec4(vec3(dirSwitch), 1.0);
}   