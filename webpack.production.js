var path = require('path');
var webpack = require('webpack');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var BowerWebpackPlugin = require("bower-webpack-plugin");

var devFlagPlugin = new webpack.DefinePlugin({
  __DEV__: JSON.stringify(JSON.parse(process.env.DEBUG || 'false')),
  "process.env": {
    NODE_ENV: JSON.stringify("production")
  }
});

module.exports = [

  // js
  {
    entry: {
      bundle: './src/scripts/main.js'
    },
    output: {
      path: path.join(__dirname, 'dest/assets/scripts'),
      filename: '[name].js'
    },
    resolve: {
      modulesDirctories: ['bower_components', 'node_modules', 'web_modules'],
      extensions: ['', '.webpack.js', 'web.js', '.js', '.json', '.tag']
    },
    plugins: [
      new webpack.optimize.UglifyJsPlugin(),
      new webpack.optimize.OccurenceOrderPlugin(),
      new webpack.optimize.DedupePlugin(),
      new BowerWebpackPlugin(),
      new webpack.ProvidePlugin({
        riot: 'riot'
      }),
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
    entry: {
      bundle: './src/styles/main.scss'
    },
    output: {
      path: path.join(__dirname, 'dest/assets/styles'),
      filename: '[name].css'
    },
    resolve: {
      modulesDirctories: ['bower_components', 'node_modules', 'web_modules'],
      extensions: ['','.css','.scss']
    },
    plugins: [
      new webpack.optimize.UglifyJsPlugin(),
      new webpack.optimize.OccurenceOrderPlugin(),
      new webpack.optimize.DedupePlugin(),
      new BowerWebpackPlugin(),
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
  },

  // html
  {
    entry: {
      index: './src/index.html'
    },
    output: {
      path: path.join(__dirname, 'dest'),
      filename: '[name].html'
    },
    plugins: [
      new webpack.optimize.UglifyJsPlugin(),
      new webpack.optimize.OccurenceOrderPlugin(),
      new webpack.optimize.DedupePlugin(),
      new ExtractTextPlugin('[name].html'),
      devFlagPlugin
    ],
    module: {
      loaders: [
        {
  				test: /\.html$/,
  				loader: ExtractTextPlugin.extract('html')
  			}
      ]
    }
  }
];
