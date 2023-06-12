<template>
	<TresCanvas v-bind="gl" window-size>
		<TresPerspectiveCamera :position="[0, 0, 3.5]" :look-at="[0, 0, 0]" />

		<Suspense>
			<Wall ref="wallRef" />
		</Suspense>
	</TresCanvas>
</template>

<script setup>
import { TresCanvas } from '@tresjs/core'
import { useTweakPane } from '@tresjs/cientos'

//
// Refs
//
const wallRef = shallowRef(null)

const { pane } = useTweakPane()

const gl = reactive({
	clearColor: '#2c2c2c',
	powerPreference: 'high-performance',
})

//
// Lifecycle
//
onMounted(async () => {
	await nextTick()

	// Do stuff on mount
	createGlobalDebugPane()
})

//
// Watchers
//
// watch(wallRef, value => {
// 	if (!value) return
// 	createWallDebugPanel()
// })

//
// Functions
//
function createGlobalDebugPane() {
	pane.addInput(gl, 'clearColor', { label: 'Clear Color' })
}

function createWallDebugPanel() {
	pane.addInput(wallRef.value.$el.material.uniforms.u_Transition, 'value', {
		label: 'Transition',
		min: 0,
		max: 1,
		step: 0.01,
	})
}
</script>
