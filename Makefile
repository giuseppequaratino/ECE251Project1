# Makefile
.PHONY: clean
all: operate.out

operate.out: operate.S
        arm-linux-gnueabi-gcc $< -o $@ -ggdb3 -static -mfpu=vfp -mfloat-abi=hard -lm
clean:
        rm -f operate.out
