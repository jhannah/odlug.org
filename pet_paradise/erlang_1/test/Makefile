SUFFIXES=.t .erl

ERL_FILES=$(wildcard *.erl)
TEST_FILES=$(ERL_FILES:%.erl=%.t)

all: $(TEST_FILES)

%.t: module=$(@:%.t=%)
%.t: %.erl
	sed -e 's/[@]module[@]/$(module)/g' < template.t.in > $@
