CXX = clang++
CXXFLAGS = -std=c++17 -g -Wall -Wextra -pedantic
OPENCV_LIBS = -lopencv_imgcodecs -lopencv_core -lopencv_imgproc -lopencv_video -lopencv_videoio

all: our-movie

our-movie: our-movie.o sprite.o asciimation.o
	$(CXX) -o $@ $(CXXFLAGS) $^ $(OPENCV_LIBS)

our-movie.o: our-movie.cpp sprite.hpp asciimation.hpp
	$(CXX) -c $(CXXFLAGS) -isystem /usr/include/opencv4 $<

sprite.o: sprite.cpp sprite.hpp
	$(CXX) -c $(CXXFLAGS) -isystem /usr/include/opencv4 $<
	
asciimation.o: asciimation.cpp asciimation.hpp sprite.hpp
	$(CXX) -c $(CXXFLAGS) -isystem /usr/include/opencv4 $<

clean:
	rm -rf *.o our-movie