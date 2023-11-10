all: byte # native

byte:
	dune build host.cma

native:
	dune build host.cmxa

doc:
	dune build @doc

clean:
	dune clean

clobber: clean
	@rm -f *~
