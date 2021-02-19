# Makefile
.PHONY: clean
all: concat.out

concat.out: concat.S
	arm-linux-gnueabi-gcc $< -o $@ -ggdb3 -static

clean:
	rm -f concat.out
