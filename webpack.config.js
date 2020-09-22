const path = require('path')

module.exports = {
  mode: 'development',
  entry: './src/client/index.jsx',
  output: {
    path: path.join(__dirname, 'public'),
    filename: 'app.js'
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /(node_modules|public)/,
        loaders: ['babel-loader']
      }, {
        test: /\.(css)$/,
        exclude: /(node_modules|public)/,
        loaders: ['style-loader','css-loader']
      }
    ]
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  }
}