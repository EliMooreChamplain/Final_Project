#version 120



uniform float frameTimeCounter;
uniform mat4 gbufferProjection;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferModelView;
uniform vec3 cameraPosition;

varying vec3 tintColor;
varying vec3 normal;
varying vec4 texcoord;

void main()
{
  vec4 position = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;

  vec3 worldpos = position.xyz + cameraPosition;

  texcoord = gl_MultiTexCoord0;
  tintColor = gl_Color.rgb;
  normal = gl_NormalMatrix * gl_Normal;
  gl_Position = gl_ProjectionMatrix * gbufferModelView * position;
}
