#version 120

uniform sampler2D texture;

varying vec3 tintColor;
varying vec3 normal;
varying vec4 texcoord;

void main()
{
  vec4 waterColor = texture2D(texture, texcoord.st);
  waterColor.rgb *= tintColor;

  //waterColor.rgb = vec3(1,0,0);


  gl_FragData[0] = waterColor;
}
