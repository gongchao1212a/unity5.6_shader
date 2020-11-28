using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class csharp_offset : MonoBehaviour {

    [Range(0,2)]
    public float offset;

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
            float t = (Mathf.Sin(Time.time));
            t = t * 2;
            material.SetFloat("_Offset", t);
        }
       
    }
}
