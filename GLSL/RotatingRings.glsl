void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // polar coordinate systems 
    vec2 uv = fragCoord / iResolution.xy;
    uv = (uv - vec2(0.5,0.5))*2.0;

    float PI = 3.141592;
    float PI2 = PI * 2.0;

    float circleSize = 0.5;
    float circleThickness = 0.01;
    float circleOffsetX = sin(iTime*0.1)*0.1;
    float circleOffsetY = sin(iTime*0.1);


    float c = abs((sin(iTime*0.5)+3.0)*2.0);

    float steps =(c);
    float circles = 0.0;
    for (float i = 0.0; i < steps; i++)
    {
        vec2 pos = vec2(0.5+circleOffsetX,(i/steps)+circleOffsetY);

        vec2 posFp = vec2(pos.x*(cos(pos.y*PI2)),pos.x*(sin(pos.y*PI2)));

        float mask = distance(uv,posFp);
        float circle = step(distance(mask,circleSize),circleThickness);


        circles += circle;
    }


    vec3 color = vec3(circles);

    

    fragColor = vec4(color, 1.0);
} 