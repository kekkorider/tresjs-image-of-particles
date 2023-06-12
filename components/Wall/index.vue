<template>
	<TresPoints @pointer-move="onPointermove">
		<TresPlaneGeometry :args="[1.92 * 2, 1.2 * 2, 192, 120]" />
		<TresShaderMaterial v-bind="material" />
	</TresPoints>
</template>

<script setup>
import { useLoader, useRenderLoop } from '@tresjs/core'
import { TextureLoader, Vector2 } from 'three'

import fragmentShader from './fragment.glsl'
import vertexShader from './vertex.glsl'

const { onLoop } = useRenderLoop()
const { $gsap } = useNuxtApp()

const pointerVector = new Vector2()

const texture = await useLoader(TextureLoader, '/texture-03.jpg')

const material = {
	vertexShader,
	fragmentShader,
	uniforms: {
		t_Map: { value: texture },
		u_Time: { value: 0 },
		u_Mouse: { value: new Vector2() },
		u_MouseIntensity: { value: 1 },
	},
	defines: {
		USE_UV: '',
	},
	transparent: true,
	depthWrite: false,
	depthTest: false,
}

const xTo = $gsap.quickTo(material.uniforms.u_Mouse.value, 'x', {
	duration: 0.45,
})

const yTo = $gsap.quickTo(material.uniforms.u_Mouse.value, 'y', {
	duration: 0.45,
})

const intensityTo = $gsap.quickTo(material.uniforms.u_MouseIntensity, 'value', {
	duration: 0.1,
	overwrite: 'auto',
})

onMounted(async () => {
	await nextTick()

	onLoop(({ elapsed }) => {
		material.uniforms.u_Time.value = elapsed
	})
})

function onPointermove(ev) {
	pointerVector.set(ev.point.x, ev.point.y)

	xTo(ev.point.x)
	yTo(ev.point.y)
	intensityTo(material.uniforms.u_Mouse.value.distanceTo(pointerVector))
}
</script>
