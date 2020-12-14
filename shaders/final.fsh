#version 120

uniform int isEyeInWater;
uniform float frameTimeCounter;

varying vec4 texcoord;

uniform sampler2D gcolor;

void main()
{

  vec3 color = texture2D(gcolor, texcoord.st).rgb;

  if(isEyeInWater == 1)
  {
    color.b += 0.5;
  }
  color.x += sin(frameTimeCounter) * 0.5 + 0.5;
  color.y += sin(2.0 * frameTimeCounter) * 0.5 + 0.5;
  color.z += sin(1.2 * frameTimeCounter) * 0.5 + 0.5;

  gl_FragColor = vec4(color.x, color.y, color.z, 1.0f);
}
