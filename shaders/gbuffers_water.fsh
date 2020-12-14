#version 120

uniform sampler2D texture;

varying vec3 tintColor;
varying vec3 normal;
varying vec4 texcoord;

// LIGHT INFORMATION
// sLight: struct to keep light elements together
//	  sCenter: center of light
//	  sColor: color of light
//	  sIntensity: intensity of light
struct sLight
{
    vec4 sCenter;
    vec3 sColor;
    float sIntensity;
};

// initLight: initializing light
//	  light: final light struct
//	  center: center of light
//	  color: color of light
//	  intensity: intensity of light
void initLight(out sLight light, in vec4 center, in vec3 color, in float intensity)
{
    light.sCenter = center;
    light.sColor = color;
    light.sIntensity = intensity;
}

vec3 lambertReflect(sLight light)
{
    vec3 lightVector = normalize(light.sCenter - normalize(normal.xyz));
    vec3 diffuseCoefficient = normal.xyz * lightVector;

    vec3 attenuation = 1.0 / (1.0 + ((light.sCenter - vec3(normal.xyz)) / light.sIntensity) + (((light.sCenter - vec3(normal.xyz)) * (light.sCenter - vec3(normal.xyz)) / (light.sIntensity * light.sIntensity))));

    vec3 diffuseIntensity = diffuseCoefficient * attenuation;

	  return diffuseIntensity;
}

vec3 finalColor(sLight light, vec3 reflectionColor)
{
  return lambertReflect(light) * reflectionColor * light.sColor;
}

void main()
{
  vec4 waterColor = texture2D(texture, texcoord.st);
  //waterColor.rgb *= tintColor;

  waterColor.rgb = vec3(0.25,0.5,1.0);
  waterColor.rgb *= tintColor;

  sLight sun;
  vec4 center = sunPosition;
  vec3 lightColor = vec3(1, 1, 1);
  float intensity = 1.0;
  initLight(sun, center, lightColor, intensity);

  vec4 finalLight = vec4(finalColor(sun, waterColor,1.0);

  gl_FragData[0] = finalLight;
}
