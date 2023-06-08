varying vec2 vUv;
varying float vDistance;

uniform sampler2D t_Map;

void main() {
  float d = length(gl_PointCoord - vec2(0.5));
  d = smoothstep(0.5, 0.15, d);

  vec4 tex0 = texture2D(t_Map, vUv);
  tex0.a *= d;

  vec4 tex1 = vec4(
    vec3((tex0.r + tex0.g + tex0.b) / 3.0),
    tex0.a
  );

  vec4 color = mix(tex1, tex0, vDistance*2.0);
  gl_FragColor = color;
}
