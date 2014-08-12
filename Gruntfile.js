module.exports = function(grunt) {

    "use strict";

    grunt.initConfig({ 
    
        pscMake: {
            options: {
            },
            main: {
                files: {
                    src: ["src/**/*.purs"]
                }
            },
        }
    });

    grunt.loadNpmTasks("grunt-purescript");
    grunt.registerTask("default", ["pscMake:main"]);
};
