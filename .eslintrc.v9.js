import { FlatCompat } from "@eslint/eslintrc";

const compat = new FlatCompat({
    recommendedConfig: {},
});

export default [
    ...compat.extends("eslint:recommended"),
    ...compat.extends("standard"),

    {
        files: ["**/*.js"],

        languageOptions: {
            ecmaVersion: 2018,
            sourceType: "module",
            globals: {
                Atomics: "readonly",
                SharedArrayBuffer: "readonly",
            },
        },

        rules: {
            "for-direction": "error",
            "no-extra-semi": "error",
            "n/no-deprecated-api": "off",
            "n/no-path-concat": "off",
            "n/handle-callback-err": "off",
        },
    },
];
