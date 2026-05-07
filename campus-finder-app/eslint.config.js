import globals from 'globals'
import pluginVue from 'eslint-plugin-vue'

export default [
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        uni: 'readonly',
        plus: 'readonly',
        wx: 'readonly',
        UniApp: 'readonly'
      }
    }
  },
  ...pluginVue.configs['flat/recommended'],
  {
    rules: {
      'vue/multi-word-component-names': 'off',
      'vue/no-v-model-argument': 'off',
      'no-unused-vars': ['warn', { argsIgnorePattern: '^_' }]
    }
  },
  {
    ignores: ['dist/**', 'node_modules/**', 'unpackage/**']
  }
]
