float4 main(float2 uv : TEXCOORD0) : SV_TARGET
{
    float shift = 0.2 ; 
    float scaleX = 20 ;
    float scaleY = 30 ;

    float test = smoothstep(2,sin((uv.x+shift) * scaleX),(uv.y * scaleY) - (scaleY*0.5));

    float3 red = float3(1,0,0);
    float3 white = float3(1,1,1);

    float3 pol = lerp(white,red,test);
    
    float3 color = float3(pol);
    float4 OUTPUT = float4(color, 1.0);

    return OUTPUT ; 
}
