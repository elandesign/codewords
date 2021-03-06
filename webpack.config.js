var path = require("path");

module.exports = {
  context: __dirname,
  entry: {
    codewords:  "./client/codewords.js",
  },
  output: {
    path: path.join(__dirname, 'public', 'javascripts'),
    filename: "[name].js",
    publicPath: "/javascripts/"
  },
  module: {
    loaders: [
      { test: /\.js$/, exclude: /node_modules/, loader: 'babel-loader'}
    ]
  }
};
