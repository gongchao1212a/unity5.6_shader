using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class csharp_dissolve : MonoBehaviour {

    [Range(0,1)]
    public float threshold;

    protected Shader shader;
    protected Material material;

    // Use this for initialization
    void Start() {
        material = gameObject.GetComponent<Renderer>().material;
        if (material)
        {
            shader = material.shader;
        }
        if (!material || !shader)
        {
            Debug.LogError("material or shader is null");
            return;
        }
	}
	
	// Update is called once per frame
	void Update () {

        if (material)
        {
            float t = (Mathf.Sin(Time.time) + 1) * 0.5f;
            material.SetFloat("_Threshold", t);
        }
       
    }
}
