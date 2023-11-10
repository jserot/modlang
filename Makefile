build:
	dune build

doc:
	dune build @doc-private # No package, hence no public name

doc.view:
	open -a Safari _build/default/_doc/_html/host*/Host/index.html

clean:
	dune clean

clobber: clean
	rm -f *~
