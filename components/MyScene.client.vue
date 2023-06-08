<template>
	<TresCanvas v-bind="gl" window-size>
		<TresPerspectiveCamera :position="[0, 0, 3.5]" :look-at="[0, 0, 0]" />

		<Suspense>
			<Wall />
		</Suspense>
	</TresCanvas>
</template>

<script setup>
import { TresCanvas } from '@tresjs/core'
import { useTweakPane } from '@tresjs/cientos'

//
// Refs
//
const { pane } = useTweakPane()

const gl = reactive({
	clearColor: '#595959',
	powerPreference: 'high-performance',
})

//
// Lifecycle
//
onMounted(async () => {
	await nextTick()

	// Do stuff on mount
	createDebugPane()
})

//
// Functions
//
function createDebugPane() {
	pane.addInput(gl, 'clearColor', { label: 'Clear Color' })
}
</script>
