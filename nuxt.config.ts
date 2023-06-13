import glsl from 'vite-plugin-glsl'

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  app: {
    head: {
      title: 'TresJS - Images of particles',
      meta: [
        {
          name: 'description',
          content: 'ThresJS demo of a carousel whose images are made of particles'
        }
      ]
    },
  },

  css: [
    '@/assets/css/index.scss',
  ],

  nitro: {
    preset: 'vercel'
  },

  modules: [
    [
      '@nuxtjs/google-fonts', {
        prefetch: true,
        download: true,
        families: {
          'Noto+Sans': [400, 500, 700]
        }
      }
    ],
    [
      '@pinia/nuxt',
      {
        autoImports: ['defineStore', 'acceptHMRUpdate']
      }
    ]
  ],

  imports: {
    dirs: ['stores']
  },

  vue: {
    compilerOptions: {
      isCustomElement: tag => tag.startsWith('Tres') && tag !== 'TresCanvas'
    }
  },

  vite: {
    plugins: [glsl()]
  }
})
