all: ebin
	erl -make

ebin:
	mkdir -p ebin

clean:
	rm -f ebin/*.beam

test: all
	(cd test; make)
	prove test/*.t
