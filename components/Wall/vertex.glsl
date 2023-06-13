#include <uv_pars_vertex>

uniform float u_Time;
uniform vec2 u_Mouse;
uniform float u_MouseIntensity;

varying float vDistance;
varying vec3 vPosition;

#include ../../assets/shaders/lygia/generative/curl.glsl

void main() {
  #include <uv_vertex>

  #include <begin_vertex>

  float d = distance(position.xy, u_Mouse);
  transformed += curl(transformed) * sin(d * 3.0 - u_Time*3.0) * smoothstep(1.15, 0.0, d) * u_MouseIntensity * 0.65;

  #include <project_vertex>

  gl_PointSize = 30.0 * ( 1.0 / - mvPosition.z );

  vDistance = smoothstep(1.55, 0.0, d) * 0.5 * u_MouseIntensity;
  vPosition = position;
}
