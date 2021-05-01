Shader "Custom/sample_6" {
    Properties{
        _BaseColor("Base Color", Color) = (1,1,1,1)
		_RimColor("Base Color", Color) = (1,1,1,1)
    }
	SubShader {
		Tags { "Queue" = "Transparent" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard
		#pragma target 3.0

		struct Input {
			float2 uv_MainTex;
			float3 worldNormal;
			float3 viewDir;
		};
        
		fixed4 _BaseColor,
				_RimColor;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _BaseColor;

			//輪郭部分では視線ベクトル と法線が直行する。
			//saturateのほうが、absに比べ裏も正しい計算で通る
			float rim = 1 - saturate(dot(IN.viewDir, o.Normal));

			//dotをとるとcosで減衰するが、それだと輪郭だけを浮かび上がらせられないので2.5乗する
			o.Emission = _RimColor * pow(rim, 2.5);
		}
		ENDCG
	}
	FallBack "Diffuse"
}