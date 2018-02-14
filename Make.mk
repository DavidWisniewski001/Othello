################################################################################
# David Wisniewski
# Homework5 Make Files
#
#
#

all: Othello

Othello: main.o Myothello.o space.o game.o
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
	rm MyOthello
