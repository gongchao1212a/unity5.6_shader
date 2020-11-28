// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/shr_offset"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Offset ("OffSet",Range(0,5)) = 1 
		_LineWidth("LineWidth",Range(0,1)) = 0.05
		_OutColor ("OutColor",Color) = (1,1,1,1)
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
				float4 worldPos: TEXCOORD1;

			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Offset;
			float _LineWidth;
			float4 _OutColor;
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.worldPos = mul(unity_ObjectToWorld, v.vertex);
				
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float clip_value = _Offset - i.worldPos.y;
				clip(clip_value);
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				float per =saturate( clip_value / _LineWidth);
				
				return lerp (col ,_OutColor,1- per);
			}
			ENDCG
		}
	}
}
