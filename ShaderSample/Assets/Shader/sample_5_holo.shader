Shader "Custom/sample_5" {
    Properties{
        _BaseColor("Base Color", Color) = (1,1,1,1)
		_Alpha("Alpha", float) = 1
    }
	SubShader {
		Tags { "Queue" = "Transparent" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard alpha:blend
		#pragma target 3.0

		struct Input {
			float3 worldNormal;
			float3 viewDir;
		};
        
		fixed4 _BaseColor;
		float _Alpha;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _BaseColor.rgb;

			//視線方向と法線ベクトル が近いほど、透明度が上がる。
			//輪郭では透明度が低くなる。
			float alpha = 1 - (abs(dot(IN.viewDir,IN.worldNormal)));
			o.Alpha = alpha * 1.5f;
		}
		ENDCG
	}
	FallBack "Diffuse"
}