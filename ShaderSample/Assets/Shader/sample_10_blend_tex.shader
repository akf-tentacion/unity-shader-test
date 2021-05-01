Shader "Custom/sample_10" {
    Properties{
        _MainTex("Texture",2D) = "white"{}
		_SubTex("Sub Texture", 2D) = "white"{}
		_MaskTex("Mask Texture", 2D) = "white"{}
    }
	SubShader {
		Tags { "RenderType" = "Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		struct Input {
			float2 uv_MainTex;
		};
        
		sampler2D 	_MainTex,
					_SubTex,
					_MaskTex;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c1 = tex2D(_MainTex,IN.uv_MainTex);
			fixed4 c2 = tex2D(_SubTex,IN.uv_MainTex);
			fixed4 p = tex2D(_MaskTex, IN.uv_MainTex);
			o.Albedo = lerp(c1, c2, p);
		}
		ENDCG
	}
	FallBack "Diffuse"
}