/**
 * asciimation.cpp
 * Author(s):
 *
 * Part of CS70 Homework 3. This file may NOT be
 * shared with anyone other than the author(s) and
 * the current semester's CS70 staff without
 * explicit written permission from one of the
 * CS70 instructors.
 *
 */

#include "asciimation.hpp"
#include "sprite.hpp"

#include <iostream>
#include <stdexcept>
#include <cstddef>
#include <unistd.h>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

Asciimation::Asciimation(int numRows, int numCols, int rowHeight,
                         int colWidth, string spriteFilename)
            :
            numRows_{numRows},
            numCols_{numCols},
            rowHeight_{rowHeight},
            colWidth_{colWidth},
            sprite_{spriteFilename},
            spriteCurrentRow_{(numRows / 2) - (Sprite::SPRITE_HEIGHT / 2)},
            spriteCurrentCol_{0 - Sprite::SPRITE_WIDTH} {
}

void Asciimation::addFrame(VideoWriter& vw) {
    const Scalar BACKGROUND_COLOR = Scalar(0, 0, 0);
    const Scalar TEXT_COLOR = Scalar(255, 255, 255);
    const float TEXT_SCALING = 1.0;

    Mat blankImage(rowHeight_ * numRows_,
                    colWidth_ * numCols_, COLORTYPE, BACKGROUND_COLOR);

    // Changes coordinates of Sprite characters and creates new frame
    for (int row = 0; row < Sprite::SPRITE_HEIGHT; ++row) {
        for (int col = 0; col < Sprite::SPRITE_WIDTH; ++col) {
            char c = sprite_.getCharAt(row, col);
            string cStr = string(1, c);
            size_t xCoord = (col + spriteCurrentCol_) * colWidth_;
            size_t yCoord = (row + spriteCurrentRow_) * rowHeight_;
            putText(blankImage, cStr, Point(xCoord, yCoord),
                    FONT, TEXT_SCALING, TEXT_COLOR);
        }
    }
    vw.write(blankImage);
}

void Asciimation::generateMovie(const string& fname, int frameRate) {
    Size movieSize(colWidth_ * numCols_, rowHeight_ * numRows_);
    int codec = VideoWriter::fourcc('m', 'p', '4', 'v');
    VideoWriter vw;
    vw.open(fname, codec, frameRate, movieSize);
    for (int i = 0; i < numCols_ + Sprite::SPRITE_WIDTH; ++i) {
        spriteCurrentCol_ += 1;
        addFrame(vw);
    }

    vw.release();
}
