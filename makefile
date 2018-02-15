################################################################################
# David Wisniewski
# Homework5 Make Files
#
#
#
all: build archive

build: Game

Game: main.o Myothello.o space.o game.o
	clang++ main.o Myothello.o space.o game.o -o Othello

main.o: main.cc
	clang++ -c main.cc

game.o: game.cc
	clang++ -c game.cc

Myothello.o: Myothello.cc
	clang++ -c Myothello.cc

space.o: space.cc
	clang++ -c space.cc

clean:
	rm -f *.o core *.core

archive: main.cc game.cc Myothello.cc space.cc char.h  colors.h game.h space.h Myothello.h makefile
	tar -cf archive.tar main.cc game.cc Myothello.cc space.cc char.h  colors.h game.h space.h Myothello.h makefile
