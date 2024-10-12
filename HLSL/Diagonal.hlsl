float4 main(float2 uv : TEXCOORD0) : SV_TARGET
{
    float stripe1 = 0 ;

    
    float width = 0.025;
    

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
    


    float3 color = float3(stripe1,stripe1,stripe1);


    float4 OUTPUT = float4(color, 1.0);
    return OUTPUT ; 
}
