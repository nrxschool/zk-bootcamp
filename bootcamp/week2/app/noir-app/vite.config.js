export default {
  optimizeDeps: {
    esbuildOptions: { target: "esnext" },
    exclude: ["@noir-lang/noirc_abi", "@noir-lang/acvm_js"],
  },
  build: {
    target: "esnext",
    rollupOptions: {
      output: {
        format: "es"
      }
    }
  }
};
