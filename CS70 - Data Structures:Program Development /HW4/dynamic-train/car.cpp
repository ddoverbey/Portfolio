#include "car.hpp"
#include <iostream>
#include <ostream>
#include <stdexcept>
#include <cstddef>
#include <cassert>

Car::Car():
    binsInUse_{0}
{
    for (size_t i = 0; i < CAPACITY; ++i) {
        bins_[i] = false;
    }
}

size_t Car::getUsage() const {
    return binsInUse_;
}

bool Car::isFull() const {
    return binsInUse_ == CAPACITY;
}

bool Car::isEmpty() const {
    return binsInUse_ == 0;
}

void Car::addPackage() {
    assert(!isFull());
    bins_[binsInUse_] = true;
    ++binsInUse_;
}

void Car::removePackage() {
    assert(!isEmpty());
    --binsInUse_;
    bins_[binsInUse_] = false;
}

void Car::printToStream(std::ostream& outStream) const {
    // testing outStream << "[mystery car]";
    for (size_t i = 0; i < CAPACITY; ++i) {
        if (bins_[i]) {
            outStream << "[x]";
        } else {
            outStream << "[_]";
        }
    }
    outStream << "~";
}

std::ostream& operator<<(std::ostream& os, const Car& car) {
    car.printToStream(os);

    // To allow chaining of <<, we always return the stream we were given.
    return os;
}
