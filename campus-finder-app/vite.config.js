import { defineConfig } from 'vite'
import uniModule from '@dcloudio/vite-plugin-uni'
import { resolve } from 'path'

const uni = uniModule.default || uniModule

export default defineConfig({
  plugins: [uni()],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src')
    }
  },
  css: {
    preprocessorOptions: {
      scss: {
        silenceDeprecations: ['color-functions', 'global-builtin']
      }
    }
  }
})
