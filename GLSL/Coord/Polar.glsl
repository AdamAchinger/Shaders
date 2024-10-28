void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // polar coordinate systems 
    vec2 uv = fragCoord / iResolution.xy;
    vec2 cent = vec2(0.5,0.5);

    float r = distance(uv,cent)*2.0;


    float theta = cos(uv.x);
    vec2 uvP = vec2(theta,r);


    vec2 Pos = vec2(0.0,0.5);
    float dist = step(distance(Pos,uvP),0.01);
    //vec3 color = mix(vec3(uvP,0.0),vec3(1,1,1),dist);


    vec3 color = vec3(theta);
    fragColor = vec4(color, 1.0);
}   