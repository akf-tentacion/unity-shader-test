Shader "Custom/sample_10_1" {
    Properties{
        _MainTex("Texture",2D) = "white"{}
		_SubTex("Sub Texture", 2D) = "white"{}
		_MaskTex("Mask Texture", 2D) = "white"{}
		_Intensity ("intensity", Range(0,1)) = 0.5
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
        
		sampler2D 	_MainTex,
					_SubTex,
					_MaskTex;
		float _Intensity;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c1 = tex2D(_MainTex,IN.uv_MainTex);
			fixed4 c2 = tex2D(_SubTex,IN.uv_MainTex);
			fixed4 p = tex2D(_MaskTex, IN.uv_MainTex);

			//マスク画像のグレイスケールを利用してブレンド
			//さらにメイン画像のグレイスケールが1なら透過する処理をしている。
			p = lerp(0,p,_Intensity);
			p = lerp(c1, c2, p);
			o.Albedo = p;
			float gray = GetGrayScale(c1.rgb);
			o.Alpha = gray < .2 ? 1 : 0.6;

		}
		ENDCG
	}
	FallBack "Diffuse"
}