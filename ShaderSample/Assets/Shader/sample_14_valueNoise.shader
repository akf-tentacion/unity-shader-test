Shader "Custom/sample_14_ValueNoise" {
    Properties {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 200
        
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0
		#include "MyMath.cginc"

        sampler2D _MainTex;
        
        struct Input {
            float2 uv_MainTex;
        };


        void surf (Input IN, inout SurfaceOutputStandard o) {
            float c = ValueNoise(IN.uv_MainTex * 8);
            o.Albedo = fixed4(c,c,c,1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}