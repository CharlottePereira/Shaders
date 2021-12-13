Shader "Unlit/Line"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1) 
        _MainTex("Main Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        
    
        Tags
        {
            "Queue" = "Transparent"
            "Render Type" = "Transparent"
            "IgnoreProjector" = "True"
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            uniform half4 _Color;
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;

            struct VertexInput
            {
                float4 vertex: POSITION;
                float4 texcoord: TEXCOORD;
            };

            struct VertexOutput
            {
                float4 pos : SV_POSITION;
                float4 texcoord: TEXCOORD;
            };

            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            float drawLine(float2 uv, float start, float end)
            {
                if((uv.x > start && uv.x < end) || (uv.y > start && uv.y <end))
                {
                    return 1;
                }
                return 0;
            }

            half4 frag(VertexOutput i) : COLOR
            {
                float4 color = tex2D( _MainTex, i.texcoord) * _Color;
                color.a = drawLine(i.texcoord.xy, 0.4, 0.6);
                return color;
            }


            ENDCG
        }
    }
}                   // add two float properties _Start and _Width to parameter the line in the material
