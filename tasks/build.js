module.exports = function(grunt) {
  grunt.registerTask('build', 'Build the app - ready to deploy to AppEngine.', function() {

    this.requires('coffee less concat');

    var copyAll = function(src, dest) {
      grunt.log.writeln('Copy ' + src + ' -> ' + dest);
      grunt.file.expand(src).forEach(function(filepath) {
        grunt.file.copy(filepath, filepath.replace(/^app\//, dest));
      });
    };

    var copyOne = function(src, dest, process) {
      grunt.log.writeln('Copy ' + src + ' -> ' + dest);
      grunt.file.copy(src, dest, {process: process});
    };

    var BUILD = 'build/';
    var DST = 'build/task-manager-angular/';

    var cssFile = grunt.config('concat.css.dest').replace(BUILD, '');
    var jsFile = grunt.config('concat.js.dest').replace(BUILD, '');
    var angularFile = 'lib/angular/angular.js';


    // copy CSS and JS
    copyOne(BUILD + cssFile, DST + 'app/' + cssFile);
    copyOne(BUILD + jsFile, DST + 'app/' + jsFile);


    // copy and rewrite index.html
    var APP_CSS = /<!-- APP-CSS -->(.|\n)*<!-- APP-CSS-END -->/m;
    var APP_JS = /<!-- APP-JS -->(.|\n)*<!-- APP-JS-END -->/m;

    copyOne('app/index.html', DST + 'app/index.html', function(content) {
      content = content.replace(APP_CSS, '<link href="' + cssFile + '" rel="stylesheet">');
      content = content.replace(APP_JS, '<script src="' + jsFile + '" type="text/javascript"></script>');
      content = content.replace(angularFile, 'http://ajax.googleapis.com/ajax/libs/angularjs/1.0.1/angular.js');
      return content;
    });

    // font-awesome
    copyAll('app/lib/font-awesome/css/font-awesome.css', DST + 'app/');
    copyAll('app/lib/font-awesome/font/fontawesome-webfont.*', DST + 'app/');

    // App Engine stuff
    copyOne('app.yaml', DST + 'app.yaml');
    copyOne('favicon.ico', DST + 'favicon.ico');
    copyOne('index.yaml', DST + 'index.yaml');
    copyOne('main.py', DST + 'main.py');
  });
};
