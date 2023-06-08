varying vec2 vUv;
varying float vDistance;

uniform sampler2D t_Map;

#include ../../assets/shaders/lygia/color/desaturate.glsl

void main() {
  float d = length(gl_PointCoord - vec2(0.5));
  d = smoothstep(0.5, 0.15, d);

  vec4 tex0 = texture2D(t_Map, vUv);
  tex0.a *= d;

  vec4 tex1 = desaturate(tex0, 1.0);

  vec4 color = mix(tex1, tex0, vDistance*3.0);
  gl_FragColor = color;
}
