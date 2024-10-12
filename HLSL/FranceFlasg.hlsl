float4 main(float2 uv : TEXCOORD0) : SV_TARGET
{
    float3 colorR = float3(1, 0, 0);  
    float3 colorW = float3(1, 1, 1);  
    float3 colorB = float3(0, 0, 1);  
    
    float mask = step(0.333, uv.x);
    float mask1 = step(0.666, uv.x);
    
    float3 color = lerp(lerp(colorB, colorW, mask), colorR, mask1);
    
    float4 OUTPUT = float4(color, 1.0);
    return OUTPUT ; 
}
