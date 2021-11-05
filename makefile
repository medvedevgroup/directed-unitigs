CC=g++ 
CFLAGS= -Wall -O4 -std=c++0x -march=native
LDFLAGS=


ifeq ($(gprof),1)
CFLAGS=-std=c++0x -pg -march=native -O4
LDFLAGS=-pg 
endif

ifeq ($(valgrind),1)
CFLAGS=-std=c++0x -g -O0
LDFLAGS=-g 
endif



EXEC=dbcalm

all: $(EXEC)

dbcalm: main.o lm.o ograph.o debug.o
	$(CC) -o $@ $^ $(LDFLAGS)

debug.o: debug.cpp ograph.h
	$(CC) -o $@ -c $< $(CFLAGS)

main.o: main.cpp lm.h ograph.h 
	$(CC) -o $@ -c $< $(CFLAGS)

ograph.o: ograph.cpp
	$(CC) -o $@ -c $< $(CFLAGS)

lm.o: lm.cpp ograph.h
	$(CC) -o $@ -c $< $(CFLAGS)


clean:
	rm -rf *.o
	rm -rf $(EXEC)
	rm -rf *.dot
	rm -rf randomgenome


rebuild: clean $(EXEC)


