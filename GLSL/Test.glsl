
int dirSwitch = 0;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    float time = iTime;

    if(time > 100.0){
        dirSwitch = 1;
    }else{
        dirSwitch = 0;
    }

    vec3 color = vec3(0.0,0.0,0.0);




    fragColor = vec4(vec3(dirSwitch), 1.0);
}   