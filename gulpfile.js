var gulp = require('gulp'),
    jshint = require('gulp-jshint'),
    concat = require('gulp-concat'),
    rename = require('gulp-rename'),
    uglify = require('gulp-uglify'),
    browserify = require('gulp-browserify');

// Lint JS
gulp.task('lint', function() {
    return gulp.src('src/scripts/**/*.js')
        .pipe(jshint())
        .pipe(jshint.reporter('default'));
});

gulp.task('shrinkify', function() {
    return gulp.src('src/scripts/rpg.js')
        .pipe(browserify())
        .pipe(concat('rpg.js'))
        .pipe(gulp.dest('./build/js/'))
});

gulp.task('minify', function() {
    return gulp.src('./build/js/rpg.js')
        .pipe(rename('rpg.min.js'))
        .pipe(uglify())
        .pipe(gulp.dest('build/js/'));
});

gulp.task('scripts', function() {
    return gulp.src('src/scripts/rpg.js')
        .pipe(browserify())
        .pipe(concat('rpg.js'))
        .pipe(gulp.dest('./build/js/'))
        .pipe(concat('rpg.dev.js'))
        .pipe(gulp.dest('./client/assets/js/lib/'))
        .pipe(rename('rpg.min.js'))
        .pipe(uglify())
        .pipe(gulp.dest('build/js/'))
        .pipe(gulp.dest('client/assets/js/lib/'))
});

// Watch Our Files
gulp.task('watch', function() {
    gulp.watch('src/scripts/**/*.js', ['scripts']);
});

// Default
gulp.task('default', ['scripts']);
gulp.task('shrink', ['shrinkify']);
gulp.task('shrinkwrap', ['shrink', 'minify']);
gulp.task('min', ['minify']);