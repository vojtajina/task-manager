module.exports = function(grunt) {
  grunt.registerTask('appengine-update', 'Upload to App Engine.', function() {
    var spawn = require('child_process').spawn;
    var PIPE = {stdio: 'inherit'};
    var done = this.async();

    spawn('appcfg.py', ['update', 'build/task-manager-angular'], PIPE).on('exit', function(status) {
      done(status === 0);
    });
  });
};
