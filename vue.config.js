// vue.config.js
module.exports = {
  publicPath: "./",
  chainWebpack: (config) => {
    // GraphQL Loader
    config.module
      .rule("haxe")
      .test(/\.hxml$/)
      .use("haxe-loader")
      .loader("haxe-loader")
      .tap(() => {
        return {
          debug: true,
        };
      })
      .end();
  },
};
