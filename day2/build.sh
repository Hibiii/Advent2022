#!/bin/bash
CC="${CC:-cc}"
CC_PARAMS="--std=c17"
set -xe
mkdir -p obj/
"$CC" defs.c funs.c main.c -o"day2"