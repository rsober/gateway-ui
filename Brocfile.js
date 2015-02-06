/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app'),
  pickFiles = require('broccoli-static-compiler'),
  mergeTrees = require('broccoli-merge-trees');

var app = new EmberApp();

// Use `app.import` to add additional libraries to the generated
// output files.
//
// If you need to use different assets in different
// environments, specify an object as the first parameter. That
// object's keys should be the environment name and the values
// should be the asset to use in that environment.
//
// If the library that you are including contains AMD or ES6
// modules that you would like to import into your application
// please specify an object with the list of modules as keys
// along with the exports of each module as its value.

app.import('bower_components/bootstrap-sass-official/assets/javascripts/bootstrap.js')
app.import('bower_components/i18next/i18next.js');
app.import('bower_components/moment/moment.js');
app.import('bower_components/moment/locale/es.js');
app.import('bower_components/moment/locale/hi.js');
app.import('bower_components/jquery-sortable/source/js/jquery-sortable-min.js');

i18n = pickFiles('app', {
 srcDir: '/',
 files: ['locales/*/*.json'],
 destDir: '/'
});

retinaIcons = pickFiles('bower_components/bower-retina-icons', {
 srcDir: '/',
 files: ['assets/fonts/*'],
 destDir: '/'
});

module.exports = mergeTrees([
  app.toTree(),
  i18n,
  retinaIcons
]);
