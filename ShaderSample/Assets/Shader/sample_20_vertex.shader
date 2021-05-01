Shader "Custom/sample_20_vertex"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        #pragma target 3.0
        #include "MyMath.cginc"

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };
        bool IsInCircle(float2 pos, float2 origin){
			float radius = 0.2;
			return radius < distance( origin, pos );
		}
        //形状関数
		bool IsInObject(float2 pos){
			return IsInCircle(pos, float2(0.5,0.5));
		}

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void vert(inout appdata_full v, out Input o){
            UNITY_INITIALIZE_OUTPUT(Input,o);
            float amp = 0.5 * sin(_Time * 100 + v.vertex.x * 100);
            v.vertex.xyz = float3(v.vertex.x, v.vertex.y + amp, v.vertex.z);
        }

        void surf (Input IN, inout SurfaceOutput o)
        {

            o.Albedo = IsInObject(IN.uv_MainTex)? fixed4(1,1,1,1) : fixed4(1,0,0,1);
 
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            //o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
