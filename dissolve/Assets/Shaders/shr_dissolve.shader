Shader "Custom/shr_dissolve"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_NoiseTex ("Texture",2D) = "white" {}
		_Threshold ("threshold",Range(0,1)) = 0.01
		_OutColor("OutColor", Color) = (1,0,1,1)
		_LineWidth("LineWidth",Range(0,2)) = 1
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _NoiseTex;
			float4 _NoiseTex_ST;
			float _Threshold;
			fixed4 _OutColor;
			float _LineWidth;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
			
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
			
				fixed4 bb = tex2D(_NoiseTex,i.uv);
				float clipValue = bb.r -_Threshold;
				clip(clipValue);
				fixed4 aa = tex2D(_MainTex, i.uv);
				float edgeFactor = saturate(clipValue / (_LineWidth * _Threshold));
				return lerp(_OutColor,aa, edgeFactor);
			}
			ENDCG
		}
	}
}
