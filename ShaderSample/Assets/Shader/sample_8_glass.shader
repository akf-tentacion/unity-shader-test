//画像の黒い部分だけ不透明にするシェーダー

Shader "Custom/sample_8" {
    Properties{
        _MainTex("Texture",2D) = "white"{}
    }
	SubShader {
		Tags { "Queue" = "Transparent" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard alpha:blend
		#pragma target 3.0
		#include "MyMath.cginc"

		struct Input {
			float2 uv_MainTex;
		};
        
		sampler2D _MainTex;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = GetGrayScale(c) < .05 ? 1 : .6;
		}
		ENDCG
	}
	FallBack "Diffuse"
}