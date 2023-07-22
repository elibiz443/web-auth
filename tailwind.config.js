module.exports = {
  content: [
    'node_modules/preline/dist/*.js',
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('preline/plugin'),
  ],
}
