path = require('path')
cordovaServer = require('./lib/cordova_server')

config = (grunt) ->

  connect:
    options:
      hostname: '0.0.0.0'
    ios:
      options:
        port: 7000
        middleware: cordovaServer.iOS
    android:
      options:
        port: 6000
        middleware: cordovaServer.android
    web:
      options:
        keepalive: true
        middleware: cordovaServer.web
        port: 5000

  clean:
    default:
      options:
        "no-write": true
      src: ["!www/config.xml", "!www/js/spec/index.html", "!www/js/spec/lib/*.js", "www/*"]

  copy:
    fonts:
      files: [
        expand: true
        cwd: 'assets/fonts/'
        src: ['**/*']
        dest: 'www/fonts/'
      ]
    img:
      files: [
        expand: true
        cwd: 'assets/img/'
        src: ['**/*']
        dest: 'www/img/'
      ]
    compiled:
      files: [
        expand: true
        cwd: 'assets/javascripts/app/.compiled/'
        src: ['**/*']
        dest: 'www/js/app/.compiled/'
      ]
  handlebars:
    compile:
      options:
        amd: true
      src: ['assets/javascripts/app/templates/**/*.html'],
      dest: 'assets/javascripts/app/.compiled/tmpl.js'

  coffee:
    dist:
      options:
        sourceMap: true
      files: [
        expand: true
        flatten: false
        cwd: 'assets/javascripts'
        src: ['**/*.coffee']
        dest: 'www/js'
        rename: (dest, src) -> "#{dest}/#{src.replace(/\.coffee$/, '.js')}"
      ]

  less:
    compile:
      options:
        paths: ['assets/stylesheets']
      files:
        'www/css/main.css': 'assets/stylesheets/main.less'

  cssmin:
    compress:
      files:
        'www/css/main.css': ['www/css/main.css']
      options:
        keepSpecialComments: 0

  requirejs:
    cordova:
      options:
        mainConfigFile: 'www/js/app/require_config.js'
        out: 'www/js/cordova.js'
        optimize: 'uglify2'
        wrap: false
        almond: true
        preserveLicenseComments: false

  htmlbuild:
    dist:
      src: ['assets/public/index.html', 'assets/public/cordova.html']
      dest: 'www/'
      options:
        beautify: true

  mocha_phantomjs:
    options:
      reporter: 'dot'
    nerds: ['www/js/spec/index.html']

  watch:
    handlebars:
      files: 'assets/javascripts/app/templates/**/*.html'
      tasks: ['handlebars:compile']
    compiled:
      files: 'assets/javascripts/app/templates/**/*.html'
      tasks: ['copy:compiled']
    coffee:
      files: ['assets/javascripts/**']
      tasks: ['coffee']
    less:
      files: ['assets/stylesheets/**/*.less']
      tasks: ['less']
      options:
        spawn: true
    img:
      files: ['assets/img/**/*']
      tasks: ['copy:img']
    fonts:
      files: ['assets/fonts/**/*']
      tasks: ['copy:fonts']
    htmlbuild:
      files: ['assets/public/**/*.html']
      tasks: ['htmlbuild']

module.exports = (grunt) ->

  grunt.initConfig(config(grunt))

  grunt.loadNpmTasks('grunt-requirejs')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-mocha-phantomjs')
  grunt.loadNpmTasks('grunt-html-build')
  grunt.loadNpmTasks('grunt-contrib-handlebars')

  grunt.registerTask('default', ['build'])

  grunt.registerTask('build', [
    'copy'
    'coffee'
    'handlebars'
    'requirejs'
    'less'
    'cssmin'
    'htmlbuild'
  ])

  grunt.registerTask('server', [
    'coffee'
    'connect:web'
  ])

  grunt.registerTask('test', [
    'mocha_phantomjs'
  ])
