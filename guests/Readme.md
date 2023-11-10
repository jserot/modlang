This directory contains two examples of instances for the host language.

To define a new instance

1. Make sure the `host` library is available (`cd ../host/lib; make`)
2. Make a copy of the - say - `int` directory and rename it (`foo` for example)
3. Go to the `foo/lib` subdir
  - edit the files `{syntax,value,eval}.ml`
  - check that everything compiles by typing `make`
4. go to the `foo/bin` subdir
  - edit the files `guest_kw.mll`, `guest_rules.mll` and `guest_parser.mly`
  - check that everything compiles by typing `make`
5. go to `foo` dir and type `make`

The resulting compiler should be in `<root>/_default/src/guests/foo/bin/rfsmc.{bc,exe}`. 

