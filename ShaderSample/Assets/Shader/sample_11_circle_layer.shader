Shader "Custom/sample_11" {
    Properties{
    }
	SubShader {
		Tags { "RenderType" = "Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		struct Input {
			float3 worldPos;
		};
		
		bool IsInCircle(float3 pos, float3 origin){
			float radius = 1.5;
			return radius < distance( origin, pos );
		}

		bool IsInRing(float3 pos, float3 origin){
			float radius = 1.5;
			float dist = distance( origin, pos );
			return !(radius < dist && dist < radius + 0.2) ;
		}

		//sin波を折りたたんでリングを複製
		bool ConcentricCircle(float3 pos, float3 origin){
			float dist = distance(origin, pos);
			return 0.9 > abs(sin(dist * 4.0 - _Time * 50.));
		}

		//形状関数
		bool IsInObject(float3 pos){
			return ConcentricCircle(pos, float3(0,0,0));
		}
        
		void surf (Input IN, inout SurfaceOutputStandard o) {
			if(IsInObject(IN.worldPos)){
				o.Albedo = fixed4(110/255.,87/255.,139/255.,1);
			}else{
				o.Albedo = fixed4(1,1,1,1);
			}
		}
		ENDCG
	}
	FallBack "Diffuse"
}