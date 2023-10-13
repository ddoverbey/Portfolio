# This is a simple Makefile, it adds macros to example1.mak
#
# Use it by running:
#     cs70-make -f example2.mak 
# or
#     cs70-make -f example2.mak main
#
# (or specify any other target from the the file)

CXX = clang++
CXXFLAGS = -gdwarf-4 -Wall -Wextra -pedantic -std=c++17
LDFLAGS = -ltestinglogger


all: testtrain

testtrain: train.o car.o testtrain.o
	$(CXX) -o testtrain $(CXXFLAGS) $(LDFLAGS) testtrain.o train.o car.o 

testtrain.o: car.hpp train.hpp testtrain.cpp
	$(CXX) -c $(CXXFLAGS) testtrain.cpp 

train.o: train.hpp car.hpp train.cpp
	$(CXX) -c $(CXXFLAGS) train.cpp

car.o: car.hpp car.cpp
	$(CXX) -c $(CXXFLAGS) car.cpp

clean:
	rm -f *.o testtrain