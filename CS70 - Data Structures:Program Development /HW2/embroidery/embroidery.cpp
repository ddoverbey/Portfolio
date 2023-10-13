#include <cs70/turtle.hpp>
#include "embroidery.hpp"
#include <iostream>
#include <fstream>
#include <string>
#include <stdexcept>
#include <cstddef>
using namespace std;

void rect(Turtle& t, float width, float height) {
    t.pendown();  // makes turtle draw
    t.forward(width);  // makes turtle go forward (facing east)
    t.left(90);  // turtle turns 90 deg left
    t.forward(height);  // turtle moves up the height of rectangle
    t.left(90);
    t.forward(width);
    t.left(90);
    t.forward(height);
    t.gotopoint(0, 0);
}

void meetTurtle() {
    // declaring constants
    constexpr float PATCH_WIDTH = 50;
    constexpr float PATCH_HEIGHT = 40;
    constexpr int EDGE_STEP = 2;
    constexpr int TEXT_STEP = 1;
    constexpr float FONT_SCALE = 1.0;
    constexpr float SATIN_DELTA = 0.3;

    Turtle t;  // creates turtle object
    t.setStepSize(EDGE_STEP);
    t.satinon(SATIN_DELTA);
    rect(t, PATCH_WIDTH, PATCH_HEIGHT);  // draws rectangle
    t.setStepSize(TEXT_STEP);
    t.penup();

    t.gotopoint(10, 30);  // selects location for turtle to draw
    t.pendown();
    t.displayMessage("ML", FONT_SCALE);

    t.penup();
    t.gotopoint(5, 20);
    t.pendown();
    t.displayMessage("TURTAC", FONT_SCALE);

    t.penup();
    t.gotopoint(10, 10);
    t.pendown();
    t.displayMessage("DO", FONT_SCALE);

    t.end();  // finish embroidery pattern
    t.save("meet_turtle.dst");  // saves file as a dst file
}

void plotExampleData() {
    // declare constants
    constexpr float PATCH_WIDTH = 50;
    constexpr float PATCH_HEIGHT = 40;
    constexpr int EDGE_STEP = 2;
    constexpr int TEXT_STEP = 1;
    constexpr float FONT_SCALE = 1.0;
    constexpr float SATIN_DELTA = 0.3;
    constexpr int PLOT_STEP = 1;
    constexpr int NUM_DATA_POINTS = 59;
    const string INPUT_NAME = "/home/student/data/hw2/us_population_growth.txt";
    const string OUTPUT_NAME = "example_data.dst";

    float popGrowth[NUM_DATA_POINTS];
    ifstream inputFile{INPUT_NAME};

    // transfer everything into popGrowth array
    for (size_t i = 0; i < 59; ++i) {
        inputFile >> popGrowth[i];
    }
    inputFile.close();

    // find the largest float in array
    float maxFloat = 0.0;
    for (size_t i = 0; i < NUM_DATA_POINTS; ++i) {
        if (popGrowth[i] > maxFloat) {
            maxFloat = popGrowth[i];
        }
    }

    // determine how much space there is in the graph (available height)
    float availableHeight = PATCH_HEIGHT - EDGE_STEP;
    float normalizedPopGrowth[NUM_DATA_POINTS];
    float scaleFactor = 1;

    // normalizing data
    if (maxFloat != availableHeight) {
        scaleFactor = availableHeight/maxFloat;
    }

    for (size_t i = 0; i < NUM_DATA_POINTS; ++i) {
        normalizedPopGrowth[i] = scaleFactor*popGrowth[i];  // scaling data
    }

    Turtle t;
    t.setStepSize(EDGE_STEP);
    t.satinon(SATIN_DELTA);
    rect(t, PATCH_WIDTH, PATCH_HEIGHT);  // draws rectangle
    t.penup();

    // determine how much space there is in the graph (available width)
    float availableWidth = PATCH_WIDTH - EDGE_STEP;

    t.setStepSize(PLOT_STEP);

    float x = 0;
    float y = 0;
    int offSet = 1;  // how far we move the graph to the right

    // loop to graph each data point
    for (size_t i = 0; i < NUM_DATA_POINTS; ++i) {
        x = i * (availableWidth/NUM_DATA_POINTS) + offSet;
        y = normalizedPopGrowth[i];
        t.gotopoint(x, y);
        t.pendown();
    }

    // add "1992" label on peak in middle of graph
    t.penup();
    t.gotopoint(17, 33);
    t.pendown();
    t.setStepSize(TEXT_STEP);
    t.displayMessage("1992", FONT_SCALE);
    t.save("example_data.dst");  // saves file as a dst file
}

void plotStudentData() {
    // declare constants
    constexpr float PATCH_WIDTH = 50;
    constexpr float PATCH_HEIGHT = 40;
    constexpr int EDGE_STEP = 2;
    constexpr int TEXT_STEP = 1;
    constexpr float FONT_SCALE = 1.0;
    constexpr float SATIN_DELTA = 0.3;
    constexpr int PLOT_STEP = 1;
    constexpr int NUM_DATA_POINTS = 59;
    const string INPUT_NAME = "student_data.txt";
    const string OUTPUT_NAME = "student_data.dst";

    float studentData[NUM_DATA_POINTS];
    ifstream inputFile{INPUT_NAME};

    // transfer everything into studentData array
    for (size_t i = 0; i < 59; ++i) {
        inputFile >> studentData[i];
    }
    inputFile.close();

    // find the largest float in array
    float maxFloat = 0.0;
    for (size_t i = 0; i < NUM_DATA_POINTS; ++i) {
        if (studentData[i] > maxFloat) {
            maxFloat = studentData[i];
        }
    }

    // determine how much space there is in the graph (available height)
    float availableHeight = PATCH_HEIGHT - EDGE_STEP;
    float normalizedStudentData[NUM_DATA_POINTS];
    float scaleFactor = 1;

    // normalizing data
    if (maxFloat != availableHeight) {
        scaleFactor = availableHeight/maxFloat;
    }

    for (size_t i = 0; i < NUM_DATA_POINTS; ++i) {
        normalizedStudentData[i] = scaleFactor*studentData[i];  // scaling data
    }

    Turtle t;
    t.setStepSize(EDGE_STEP);
    t.satinon(SATIN_DELTA);
    rect(t, PATCH_WIDTH, PATCH_HEIGHT);  // draws rectangle
    t.penup();

    // determine how much space there is in the graph (available width)
    float availableWidth = PATCH_WIDTH - EDGE_STEP;

    t.setStepSize(PLOT_STEP);

    float x = 0;
    float y = 0;
    int offSet = 1;  // how far we move the graph to the right

    for (size_t i = 0; i < NUM_DATA_POINTS; ++i) {
        x = i * (availableWidth/NUM_DATA_POINTS) + offSet;
        y = normalizedStudentData[i];
        t.gotopoint(x, y);
        t.pendown();
    }

    // graph label "SBUCK" at top of graph
    t.penup();
    t.gotopoint(17, 33);
    t.pendown();
    t.setStepSize(TEXT_STEP);
    t.displayMessage("SBUCK", FONT_SCALE);
    t.save("student_data.dst");  // saves file as a dst file
}
