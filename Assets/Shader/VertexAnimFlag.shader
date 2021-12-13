Shader "Unlit/VertexAnimFlag"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1) 
        _MainTex("Main Texture", 2D) = "white" {}
        _Frequency("Frequency", Float) = 10
        _Amplitude("Amplitude", Float) = 0.15
        _Speed("Speed", Float) = 0.8

    }
    SubShader
    {
       
    
        Tags
        {
            "Queue" = "Transparent"
            "Render Type" = "Transparent"
            "IgnoreProjector" = "True"
        }
        

        Pass
        { 
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            uniform half4 _Color;
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;
            uniform float _Speed;
            uniform float _Amplitude;
            uniform float _Frequency;


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

            float4 vertexAnimFlag(float4 vertPos, float2 uv)
            {
                vertPos.z = vertPos.z + sin((uv.x - _Time.y* _Speed) * _Frequency)* _Amplitude * uv.x;
                return vertPos;
            }

            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
               v.vertex = vertexAnimFlag(v.vertex, v.texcoord);

               o.pos = UnityObjectToClipPos(v.vertex);
               o.texcoord.xy = (v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw);
               return o;
            }

            half4 frag(VertexOutput i) : COLOR
            {
                float4 color = tex2D(_MainTex, i.texcoord) * _Color;
                return color;
            }

 

            ENDCG
        }
    }
}
