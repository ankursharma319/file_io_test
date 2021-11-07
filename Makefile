CC=gcc
# CFLAGS=-I. -g -Wall -fsanitize=address,undefined -fno-omit-frame-pointer
CFLAGS=-I. -g -Wall
CXX      = g++
CXXFLAGS = -Wall -ansi -g -std=c++14

DEPS =
ODIR = ./obj
_OBJ = fileReader.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))
LIBS=-lm

.PHONY: valgrind clean filereader

# default build test app
fileReader: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)
	chmod a+x $@

# run valgrind
valgrind: fileReader
	valgrind --leak-check=full --log-file="./valgrind_log.txt" --show-leak-kinds=all --track-origins=yes --show-reachable=yes --trace-children=yes ./$<
	cat ./valgrind_log.txt

$(ODIR)/%.o: %.c $(DEPS) | $(ODIR)
	$(CC) -c -o $@ $< $(CFLAGS)

$(ODIR)/%.o: %.cpp $(DEPS) | $(ODIR)
	$(CXX) -c -o $@ $< $(CXXFLAGS)

$(ODIR):
	mkdir -p $@

clean:
	rm -f fileReader $(OBJ) gmon.out ./cpp ./valgrind_log.txt
	rm -rf $(ODIR)
