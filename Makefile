# Makefile
.PHONY: clean
all: code1.out

code1.out: code1.S
	arm-linux-gnueabi-gcc $< -o $@ -ggdb3 -static

clean:
	rm -f code1.out
