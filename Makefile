# Makefile
.PHONY: clean
all: string.out

string.out: string.S
	arm-linux-gnueabi-gcc $< -o $@ -ggdb3 -static

clean:
	rm -f string.out
