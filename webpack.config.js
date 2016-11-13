var path = require('path');
var webpack = require('webpack');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var BowerWebpackPlugin = require("bower-webpack-plugin");
var CopyWebpackPlugin = require('copy-webpack-plugin');

var devFlagPlugin = new webpack.DefinePlugin({
  __DEV__: JSON.stringify(JSON.parse(process.env.DEBUG || 'false'))
});

module.exports = [

  // js
  {
    devtool: 'source-map',
    entry: {
      bundle: './src/scripts/main.js'
    },
    output: {
      path: path.join(__dirname, 'src/assets/scripts'),
      filename: '[name].js'
    },
    resolve: {
      modulesDirctories: ['bower_components', 'node_modules', 'web_modules'],
      extensions: ['', '.test.js', '.js','.json', '.tag']
    },
    plugins: [
      new BowerWebpackPlugin(),
      new webpack.NoErrorsPlugin(),
      new webpack.ProvidePlugin({
        riot: 'riot/riot.min.js'
      }),
      new CopyWebpackPlugin([
        {
          from: 'node_modules/monaco-editor/dev/vs',
          to: 'vs'
        }
      ]),
      devFlagPlugin
    ],
    module: {
      loaders: [
        {
          test: /\.js|\.tag$|/,
          loader: 'babel',
          exclude: /(node_modules|bower_components)/
        }
      ]
    }
  },

  // css
  {
    devtool: 'source-map',
    entry: {
      bundle: './src/styles/main.scss'
    },
    output: {
      path: path.join(__dirname, 'src/assets/styles'),
      filename: '[name].css'
    },
    resolve: {
      modulesDirctories: ['bower_components', 'node_modules', 'web_modules'],
      extensions: ['','.css','.scss']
    },
    plugins: [
      new BowerWebpackPlugin(),
      new webpack.NoErrorsPlugin(),
      new ExtractTextPlugin('[name].css'),
      devFlagPlugin
    ],
    module: {
      loaders: [

        // css
        {
          test: /\.scss$/,
          loader: ExtractTextPlugin.extract('css!sass')
        },

        // img
        {
  				test: /\.(png|jpg|gif)$/,
  				loader: 'url?limit=8192'
  			},

        // fonts
        {
          test: /\.woff(\?v=\d+\.\d+\.\d+)?$/,
          loader: "url?limit=10000&mimetype=application/font-woff"
        },{
          test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/,
          loader: "url?limit=10000&mimetype=application/font-woff"
        },{
          test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,
          loader: "url?limit=10000&mimetype=application/octet-stream"
        },{
          test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,
          loader: "file"
        },{
          test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,
          loader: "url?limit=10000&mimetype=image/svg+xml"
        }
      ]
    }
  }
];
