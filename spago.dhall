{ name = "canvas"
, dependencies =
  [ "arraybuffer-types", "console", "effect", "exceptions", "maybe", "prelude" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
