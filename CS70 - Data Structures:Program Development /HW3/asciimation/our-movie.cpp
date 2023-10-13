/**
 * \file our-movie.cpp
 * \author Anonymized for Peer Review
 *
 * \brief Provides the main() function for creating and running
 * a specific asciimation movie.
 *
 * \details
 *
 * \remarks
 *
 */

#include <iostream>
#include <string>
#include "asciimation.hpp"

using namespace std;

void makeExampleMovie() {
    Asciimation movie(20, 80, 30, 15, "sprite-images/mystery1.txt");
    movie.generateMovie("example-movie.mp4", 25);
}

void makeStudentMovie() {
    Asciimation movie(20, 80, 30, 15, "sprite-images/student-example.txt");
    movie.generateMovie("student-example.mp4", 25);
}

int main() {
    // makeExampleMovie();
    makeStudentMovie();
}
