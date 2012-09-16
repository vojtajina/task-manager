/*global module:false*/
/*global require:false*/
module.exports = function(grunt) {

  grunt.initConfig({
    meta: {
      prefix: '(function(angular, window) {',
      suffix: '})(window.angular, window);',
      banner: '/* <%= manifest.name %> - v<%= manifest.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %> */'
    },
    concat: {
      js: {
        src: ['<banner:meta.prefix>', 'app/js/app.js', 'app/js/*/*.js', '<banner:meta.suffix>'],
        dest: 'build/tm.js'
      },
      css: {
        src: ['app/css/*.css'],
        dest: 'build/tm.css'
      }
    },
    min: {
      app: {
        src: ['<banner:meta.banner>', '<config:concat.js.dest>'],
        dest: 'build/textdrive.min.js'
      }
    },
    coffee: {
      app: ['app/coffee/**/*.coffee'],
      unit: ['test/unit/*/*.coffee']
    },
    less: {
      app: ['app/less/*.less']
    },
    watch: {
      app: {
        files: 'app/coffee/**/*.coffee',
        tasks: 'coffee:app'
      },
      unit: {
        files: 'test/unit/*/*.coffee',
        tasks: 'coffee:unit'
      },
      css: {
        files: 'app/less/*.less',
        tasks: 'less:app'
      }
    },
    coffeelint: {
      app: 'app/**/*.coffee',
      tests: 'test/**/*.coffee'
    },
    coffeelintOptions: {
      max_line_length: {
        value: 100,
        level: 'error'
      }
    }
  });

  grunt.loadTasks('tasks');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.registerTask('deploy', 'coffee less concat build appengine-update');
  grunt.registerTask('default', 'coffee less');
};
