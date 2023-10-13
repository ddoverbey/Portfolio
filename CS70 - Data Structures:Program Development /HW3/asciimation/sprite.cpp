/**
 * \file sprite.cpp
 * \author CS70 Provided Code -- do not copy or share
 *
 * \brief Implements the Sprite class
 *
 * \details
 *
 * \remarks
 *
 */

#include "sprite.hpp"
#include <iostream>
#include <stdexcept>
#include <string>
#include <cstddef>
#include <cassert>

using namespace std;

Sprite::Sprite(string fname) {
    ifstream inputFile{fname};

    // inputs fname info into contents array UwU
    for (size_t i = 0; i < SPRITE_WIDTH * SPRITE_HEIGHT; ++i) {
        contents_[i] = inputFile.get();
    }
}

char Sprite::getCharAt(int row, int col) const {
    assert(row >= 0 && row < SPRITE_HEIGHT);
    assert(col >= 0 && col < SPRITE_WIDTH);

    return contents_[(row * SPRITE_WIDTH) + col];
}
