Shader "Custom/sample20" {
    SubShader {
        Tags{"RenderType" = "Opaque"}
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        struct Input{
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutputStandard o){
            o.Albedo = fixed4(1.,1.,1.,1);
        }
        ENDCG
    }
    Fallback "Diffuse"
}