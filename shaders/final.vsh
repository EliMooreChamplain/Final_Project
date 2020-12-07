#version 120

uniform int isEyeInWater;

varying vec4 texcoord;

void main()
{

  gl_Position = ftransform();

  texcoord = gl_MultiTexCoord0;
}
