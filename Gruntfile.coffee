module.exports = (grunt)->

  # Formats template names to be sexier.
  jadeTemplateId = (filepath)->
    filepath
    .replace(
      /^\app\/modules\/(.*)\/template.jade$/
      '$1'
    )
    .replace(
      /^app\/modules\/(.*)\/directives\/(.*).jade$/
      '$1/$2/widget'
    )
    .replace(
      /^app\/modules\/directives\/(.*).jade$/
      '$1/widget'
    )
    .replace(
      /^app\/partials\/(.*).jade$/
      'partials/$1'
    )

  grunt.initConfig
    bower:
      dev:
        dest: 'build/vendor'

    rename:
      vendor_js: # Angular needs to be loaded before dependant libs. Renaming helps to not include it twice.
        files: 'build/angular.js': 'build/vendor/angular.js'
      dist: # Move the complete build files to a dist directory for easier and less messy packaging later
        files: [
          'build/dist/javascripts/application.js': 'build/application.js'
          'build/dist/javascripts/vendor.js': 'build/vendor.js'
          'build/dist/stylesheets/application.css': 'build/application.css'
          'build/dist/stylesheets/vendor.css': 'build/vendor.css'
          'build/dist/index.html': 'build/index.html'
        ]

    concat:
      vendor_js:
        files: 'build/vendor.js': ['build/angular.js', 'build/vendor/*.js', 'build/vendor/**/*.js']
      vendor_css:
        files: 'build/vendor.css': ['build/vendor/*.css']
      js:
        files: 'build/application.js': [
          'build/application.js', 'build/application.coffee.js', 'build/templates.js'
        ]

    browserify:
      dev:
        src: ['app/index.js']
        dest: 'build/application.js'
      coffee:
        src: ['app/*.coffee', 'app/**/*.coffee']
        dest: 'build/application.coffee.js'
        options:
          transform: ['coffeeify']

    jade:
      index:
        files: 'build/index.html': 'app/index.jade'

    ngjade:
      templates:
        options:
          moduleName:'letter-job'
          processName:jadeTemplateId
        files:[{
          expand: false
          src: [
            'app/modules/**/template.jade'
            'app/modules/**/directives/*.jade'
            'app/partials/**/*.jade'
          ]
          dest: 'build/templates.js'
        }]

    less:
      dev:
        files:
          'build/application.css': ['app/index.less', 'app/**/*.less']

    watch:
      # watch our source files and trigger the build processes
      src:
        files: [ # Todo: Figure out how to use 'file.[ext|ext|etc]'
          'Gruntfile.coffee' # Oh! How metta!
          'app/**/*.jade'
          'app/**/*.js'
          'app/**/*.coffee'
          'app/**/*.less'
          'app/index.coffee'
          'app/index.less'
          'app/index.jade'
          'app/index.js'
        ]
        tasks: ['build']

      # watch our compiled files and live reload in order to ensure all tasks ran
      # before firing the livereload
      dist:
        files: ['build/dist/**/*']
        options:
          reload: true
          livereload: true
          livereloadOnError: false

    notify_hooks:
      options:
        enabled: true
        success: true # whether successful grunt executions should be notified automatically
        duration: 3 # the duration of notification in seconds, for `notify-send only

  grunt.loadNpmTasks 'grunt-bower'
  grunt.loadNpmTasks 'grunt-rename'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-ngjade'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-notify'

  grunt.registerTask 'build', [
    'bower:dev'
    'rename:vendor_js'
    'concat:vendor_js'
    'concat:vendor_css'
    'browserify:dev'
    'browserify:coffee'
    'jade:index'
    'ngjade:templates'
    'less:dev'
    'concat:js'
    'rename:dist'
    'notify_hooks'
  ]

  grunt.registerTask 'default', ['build']
  grunt.task.run 'notify_hooks'
