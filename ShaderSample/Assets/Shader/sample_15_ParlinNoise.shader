Shader "Custom/sample_15_PerlinNoise" {
    Properties {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 200
        
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0
		#include "PerlinNoise2D.cginc"

        sampler2D _MainTex;
        
        struct Input {
            float2 uv_MainTex;
        };


        void surf (Input IN, inout SurfaceOutputStandard o) {
            float c = cnoise(IN.uv_MainTex * 32) / 2 + 0.5f;
            o.Albedo = fixed4(c,c,c,1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}