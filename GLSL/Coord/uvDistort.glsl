void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // polar coordinate systems 
    vec2 uv = fragCoord / iResolution.xy;
    float PI = 3.141592;
    vec2 cent = vec2(0.0,0.0);
    float uvScale = 5.06; 
    float distPower = 2.27;

    uv = uv - vec2(0.5,0.5);
    uv *= uvScale ; 
    
    vec2 uvDis = uv * distance(uv,cent) * distPower;
    // TestGrid

    float gridX = mod(floor(uvDis.x),2.0);
    float gridY = mod(floor(uvDis.y),2.0);

    float grid = (gridX + gridY) - ((gridX * gridY)*2.0);


    vec3 OUT = vec3(grid);
    fragColor = vec4(OUT, 1.0);
}   