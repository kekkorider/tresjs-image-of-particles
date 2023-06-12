varying vec2 vUv;
varying float vDistance;
varying vec3 vPosition;

uniform sampler2D t_Map0;
uniform sampler2D t_Map1;

uniform float u_Transition;
uniform vec2 u_TransitionOrigin;

#include ../../assets/shaders/lygia/color/desaturate.glsl
#include ../../assets/shaders/lygia/color/luminance.glsl

void main() {
  float d = length(gl_PointCoord - vec2(0.5));
  d = smoothstep(0.5, 0.15, d);

  // Texture 0
  vec4 tex0 = texture2D(t_Map0, vUv);
  tex0.rgb += 0.5 * vDistance * luminance(tex0);
  tex0.a *= d;

  vec4 tex0bn = desaturate(tex0, 1.0);

  // Texture 1
  vec4 tex1 = texture2D(t_Map1, vUv);
  tex1.a *= d;

  vec4 tex1bn = desaturate(tex1, 1.0);

  // Colors
  vec4 color0 = mix(tex0bn, tex0, vDistance*3.0);
  vec4 color1 = mix(tex1bn, tex1, vDistance*3.0);

  float transition = smoothstep(1.0, 0.2, length(vPosition.xy - u_TransitionOrigin) / (u_Transition * 9.0));
  vec4 color = mix(color0, color1, transition);

  gl_FragColor = color;
}
