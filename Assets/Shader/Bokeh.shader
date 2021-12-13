Shader "Unlit/Bokeh"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1) 
        _Feather("Feather", Range(0, 0.5)) = 0.05
        _MainTex("Main Texture", 2D) = "white" {}
        _Center("Center", Float) = 0.5
        _Radius("Radius", Float) = 0.5
        _Speed("Speed", Float) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }              //le shader marche pas 
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
            uniform float _Center;
            uniform float _Radius;
            uniform float _Feather;
            uniform float _Speed;

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

            float drawCircleAnimate(float2 uv, float2 center, float radius, float feather)
            {
                float circle = pow((uv.y - center.y),2) + pow((uv.x - center.x),2);
                float radiusSquare = pow(radius, 2);
                if (circle < radiusSquare)
                {
                    float fade = sin(_Time.y * _Speed);
                    return smoothstep(radiusSquare, radiusSquare - feather, circle) * fade; 
                }
                return 0;
            }


            ENDCG
        }
    }               
}
