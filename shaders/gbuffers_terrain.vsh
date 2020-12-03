#version 120

uniform float frameTimeCounter;
uniform mat4 gbufferProjection;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferModelView;
uniform vec3 cameraPosition;

attribute vec4 mc_Entity;

varying vec3 tintColor;
varying vec3 normal;
varying vec4 texcoord;

vec3 addWave(in vec3 worldpos, in float steepness, in float height, in float speed, in vec2 direction, in float frequency)
{
  vec3 finalOffset;
  finalOffset.x = steepness * height * direction.x * cos(dot(frequency * direction, worldpos.xz) + speed * frameTimeCounter);
  finalOffset.z = steepness * height * direction.y * cos(dot(frequency * direction, worldpos.xz) + speed * frameTimeCounter);
  finalOffset.y = height * sin(dot(frequency * direction, worldpos.xz) + speed * frameTimeCounter);
  return finalOffset;
}

void main()
{
  vec4 position = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;

  vec4 posFromPlayer = gbufferModelView * position;

  vec3 worldpos = position.xyz + cameraPosition;
  vec4 offset = vec4(0,0,0,0);




  if(mc_Entity.x == 10001)
  {
    offset.y += 0.5;
  }

  if(mc_Entity.x == 10002)
  {
    offset.xyz = addWave(
      worldpos, //World Position
      0.5, //Steepness
      0.05, //Height
      2.0f, //Speed
      vec2(0.5,0.5), //Direction
      3.0 //Frequency
      );

    offset.xyz += addWave(
        worldpos, //World Position
        0.5, //Steepness
        0.05, //Height
        1.2f, //Speed
        vec2(-0.2,-0.2), //Direction
        2.0 //Frequency
        );
  }

  offset.y = clamp(offset.y, -0.5, 0.2);

  position += offset;



  texcoord = gl_MultiTexCoord0;
  tintColor = gl_Color.xyz;
  normal = gl_NormalMatrix * gl_Normal;

  gl_Position = gl_ProjectionMatrix * gbufferModelView * position;

}
