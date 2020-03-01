// vue.config.js
module.exports = {
  devServer: {
    proxy: 'http://localhost:8080',
    port: 8081
  },
  runtimeCompiler: true
}
