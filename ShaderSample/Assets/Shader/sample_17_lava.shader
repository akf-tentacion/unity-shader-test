Shader "Unlit/sample_17_lava"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                half2   p = i.uv,
                        a = p * 10.;    //解像度変更
                a.x -= _Time.w * 0.3;
                a.y -= _Time.w * 0.5;   //Time (t/20, t, t*2, t*3), use to animate things inside the shaders.
                half2 f = frac(a);
                a -= f;     //小数部を取り除いて格子点にする
                f = f * f * (3.0 - 2.0 * f);    //ゆるやかに補間してカドをとる
                //f = f;
                //half4 r = frac(sin((a.x + a.y*1e3) + half4(0, 1, 1e3, 1001)) * 1e5)*30./p.y;
                half4 r = frac(sin((a.x + a.y*1e3) + half4(0, 1, 1e3, 1001)) * 1e5)*50./p.y;    //わからん
                return half4(p.y+half3(1,.5,.2) * clamp(lerp(lerp(r.x, r.y, f.x), lerp(r.z, r.w, f.x), f.y)-30., -.2, 1.),1);
                //UNITY_APPLY_FOG(i.fogCoord, col);
            }
            ENDCG
        }
    }
}
