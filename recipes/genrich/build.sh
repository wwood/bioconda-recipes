#!/bin/bash

mkdir -p $PREFIX/bin

mkdir -p build
cd build

make
cp Genrich $PREFIX/bin

