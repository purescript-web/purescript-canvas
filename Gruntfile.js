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
        },

        docgen: { 
          readme: {
            src: "src/**/*.purs",
            dest: "README.md"
          }
        }
    });

    grunt.loadNpmTasks("grunt-purescript");
    grunt.registerTask("default", ["pscMake:main", "docgen:readme"]);
};
