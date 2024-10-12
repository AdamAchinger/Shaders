float4 main(float2 uv : TEXCOORD0) : SV_TARGET
{
    float stripe1 = 0 ;
    float stripe2 = 0 ;

    
    float width = 0.05;
    

    if(uv.x >= uv.y){
        stripe1 = 1;
    }
    if(uv.x >= uv.y + width){
        stripe1 = 0 ;
    }
    if(uv.x <= uv.y){
        stripe1 = 1 ; 
    }
    if(uv.x <= uv.y - width){
        stripe1 = 0 ; 
    }
    
    if(uv.y >= (uv.x * -1.0 + 1.0)){
        stripe2 = 1;
    }
    if(uv.y >= (uv.x * -1.0 + 1.0) + width){
        stripe2 = 0;
    }
    if(uv.y <= (uv.x * -1.0 + 1.0)){
        stripe2 = 1;
    }
    if(uv.y <= (uv.x * -1.0 + 1.0) - width){
        stripe2 = 0;
    }


    float mix = clamp(stripe1 + stripe2,0,1) ;

    float3 colorMask = uv.x * mix;
    float3 color = float3(colorMask);


    float4 OUTPUT = float4(color, 1.0);
    return OUTPUT ; 
}
