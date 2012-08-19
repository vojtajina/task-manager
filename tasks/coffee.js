module.exports = function(grunt) {
  grunt.registerMultiTask('coffee', 'Compile coffee script.', function() {
    var coffee = require('coffee-script');
    // using patched grunt, see https://github.com/cowboy/grunt/issues/46
    var files = grunt._watch_changed_files || grunt.file.expand(this.data);

    files.forEach(function(filepath) {
      grunt.log.writeln('Compiling ' + filepath);

      try {
        // TODO(vojta): make this async
        var js = coffee.compile(grunt.file.read(filepath), {bare: true});
        var jsFilePath = filepath.replace('/coffee/', '/js/').replace(/\.coffee$/, '.js');
        grunt.file.write(jsFilePath, js);
        grunt.log.writeln('Generated ' + jsFilePath);
      }
      catch (e) {
        grunt.log.error(e.message);
      }
    });
  });
};
