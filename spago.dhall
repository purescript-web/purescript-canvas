{ name = "canvas"
, dependencies =
  [ "arraybuffer-types", "effect", "exceptions", "maybe", "prelude" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
