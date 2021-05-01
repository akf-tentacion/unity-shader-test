Shader "Custom/sample_19_toon"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MidColor("MidColor", Color) = (1,1,1,1)
        _DarkColor("DarkColor", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MidThreshold("MidLightThreshold",Range(0,1)) = 1
        _DarkThreshold("DarkLightThreshold",Range(0,1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        //カスタムライティング
        #pragma surface surf ToonRamp
        #pragma target 3.0

        sampler2D _MainTex;
        float   _MidThreshold,
                _DarkThreshold;

        fixed4  _Color,
                _MidColor,
                _DarkColor;
        

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            half d = dot(s.Normal, lightDir) * 0.5 + 0.5;
            fixed3 ramp = _Color;
            if(d < _DarkThreshold){
                ramp = _DarkColor;
            }else if(d < _MidThreshold){
                ramp = _MidColor;
            }
            fixed4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * ramp;
            c.a = 0;
            return c;
            
        }

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        //カスタムライティングを行うためには、出力をSurfaceOutputにする必要がある。
        //EmissionやSmoothnessの定義なし
        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
