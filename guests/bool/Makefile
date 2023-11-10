all:
	dune build ./lib/guest_bool.cma
	dune build ./bin/main.bc

.PHONY: test

test:
	(cd test; make)

clean:
	(cd lib; make clean)
	(cd bin; make clean)
