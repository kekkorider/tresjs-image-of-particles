#include <uv_pars_vertex>

uniform float u_Time;
uniform vec2 u_Mouse;
uniform float u_MouseIntensity;

varying float vDistance;

void main() {
  #include <uv_vertex>

  #include <begin_vertex>

  float d = distance(position.xy, u_Mouse);
  transformed.z += sin(d * 7.0 - u_Time*3.0) * smoothstep(1.15, 0.0, d) * 0.5 * u_MouseIntensity;

  #include <project_vertex>

  gl_PointSize = 5.0;

  vDistance = smoothstep(1.55, 0.0, d) * 0.5 * u_MouseIntensity;
}
