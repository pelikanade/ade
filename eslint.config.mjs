import tseslint from 'typescript-eslint';
import eslintReact from '@eslint-react/eslint-plugin';
import reactHooks from 'eslint-plugin-react-hooks';

const noCommentsPlugin = {
  rules: {
    'no-comments': {
      meta: {
        type: 'problem',
        docs: {
          description: 'Disallow comments in source files.',
        },
        schema: [],
        messages: {
          unexpected: 'Comments are not allowed.',
        },
      },
      create(context) {
        return {
          Program() {
            for (const comment of context.sourceCode.getAllComments()) {
              context.report({
                loc: comment.loc,
                messageId: 'unexpected',
              });
            }
          },
        };
      },
    },
  },
};

export default tseslint.config(
  {
    ignores: [
      'node_modules/**',
      '.devenv/**',
      '.direnv/**',
      '.expo/**',
      'dist/**',
      'dist-native/**',
      'expo-env.d.ts',
      'uniwind-types.d.ts',
    ],
  },
  tseslint.configs.strict,
  eslintReact.configs['strict-typescript'],
  reactHooks.configs.flat['recommended-latest'],
  {
    files: ['app/**/*.{ts,tsx}', 'metro.config.js'],
    rules: {
      '@typescript-eslint/no-require-imports': 'off',
    },
  },
  {
    plugins: {
      local: noCommentsPlugin,
    },
    rules: {
      'local/no-comments': 'error',
    },
  }
);
