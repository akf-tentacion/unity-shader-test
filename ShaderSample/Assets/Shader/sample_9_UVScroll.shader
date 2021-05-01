//画像の黒い部分だけ不透明にするシェーダー

Shader "Custom/sample_9" {
    Properties{
        _MainTex("Texture",2D) = "white"{}
    }
	SubShader {
		Tags { "RenderType" = "Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0
		#include "MyMath.cginc"

		struct Input {
			float2 uv_MainTex;
		};
        
		sampler2D _MainTex;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed2 uv = IN.uv_MainTex;
			uv.x += 0.5 * _Time;
			uv.y += 0.7 * _Time;
			o.Albedo = tex2D(_MainTex, uv);
		}
		ENDCG
	}
	FallBack "Diffuse"
}