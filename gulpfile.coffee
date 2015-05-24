gulp       = require 'gulp'
gutil      = require 'gulp-util'
coffee     = require 'gulp-coffee'
mocha      = require 'gulp-mocha'
watch      = require 'gulp-watch'
clean      = require 'rimraf'
coffeelint = require 'gulp-coffeelint'

require 'coffee-script/register'

gulp.task 'mocha', ->
  gulp.src 'test/*.coffee'
    .pipe mocha { reporter: 'spec'}

gulp.task 'coffeelint', ->
  gulp.src(['scripts/*.coffee', 'test/*.coffee'])
    .pipe coffeelint()
    .pipe coffeelint.reporter 'default'

gulp.task 'watch', ->
  gulp
    .watch ['scripts/*.coffee', 'test/*.coffee'], ['mocha', 'coffeelint']
