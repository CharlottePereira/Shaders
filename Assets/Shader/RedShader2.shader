Shader "Unlit/RedShader2"
{ 
    
    Properties
    {
        _Color ("Color", Color) = (1, 0, 0, 1) 
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass //un shader peut avoir plusieurs pass, ici il n'y en a qu'un
        {
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            //#pragma multi_compile_fog 

            #include "UnityCG.cginc"

           fixed4 _Color;

            struct appdata
            {
                float4 vertex : POSITION;
                float4 texcoord: TEXCOORD;
            };

            struct v2f
            {

                float4 vertex : SV_POSITION;
                float4 texcoord: TEXCOORD;
            };

            //sampler2D _MainTex;
            //float4 _MainTex_ST;

            //vertex shader
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);      //transforms vertices into coordinates
               // o.uv = TRANSFORM_TEX(v.uv, _MainTex);         //transform texture into coordinates
                //UNITY_TRANSFER_FOG(o,o.vertex);               //put a fog on the vertex shader
                return o;
            }

            //fragment shader
            fixed4 frag (v2f i) : SV_Target
            {
                //return fixed4(1,0,0,1);

                // sample the texture
                //fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
               // UNITY_APPLY_FOG(i.fogCoord, col);             //renvoi la couleur
                return _Color;
            }
            ENDCG
        }
    }
}
