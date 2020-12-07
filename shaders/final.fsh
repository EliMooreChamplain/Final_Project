#version 120

uniform int isEyeInWater;

varying vec4 texcoord;

uniform sampler2D gcolor;

void main()
{



  vec3 color = texture2D(gcolor, texcoord.st).rgb;

  if(isEyeInWater == 1)
  {
    color.b += 0.5;
  }

  gl_FragColor = vec4(color.x, color.y, color.z, 1.0f);
}
