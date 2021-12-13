Shader "Custom/Start"
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

            half4 frag(VertexOutput i) : COLOR
            {
                return _Color;
            }


            ENDCG
        }
    }
}
