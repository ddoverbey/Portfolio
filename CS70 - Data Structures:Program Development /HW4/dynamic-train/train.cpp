#include "car.hpp"
#include "train.hpp"
#include <iostream>
#include <ostream>
#include <stdexcept>
#include <cstddef>
#include <cassert>
#include <cmath>

Train::Train(traintype type):
    cars_{new Car[1]},
    numCars_{1},
    usage_{0},
    revenue_{0},
    operatingCost_{0},
    type_{type}
{
}

Train::~Train() {
    delete[] cars_;
}

void Train::addPackage() {
    upsizeIfNeeded();
    loadPackage();
    revenue_ += SHIPPING_COST;
}

void Train::loadPackage() {
    // finds the first car with open space in it
    size_t carIndex = usage_ / Car::CAPACITY;
    cars_[carIndex].addPackage();
    ++usage_;
    operatingCost_ += HANDLING_COST;
}

void Train::removePackage() {
    if (usage_ == 0) {
        // the train is empty and you can't remove packages
        return;
    }
    --usage_;
    // finds the last car with a package in it
    size_t carIndex = usage_ / Car::CAPACITY;
    cars_[carIndex].Car::removePackage();
    downsizeIfNeeded();
}

void Train::size_changeSize(size_t size) {
    Car* oldCars = cars_;
    size_t oldNumCars = numCars_;
    cars_ = new Car[size];
    numCars_ = size;
    usage_ = 0;

    // iterate over old cars
    for (size_t i = 0; i < oldNumCars; ++i) {
        while (!oldCars[i].isEmpty()) {
            oldCars[i].removePackage();
            loadPackage();
        }
    }
    delete[] oldCars;
}

void Train::upsizeIfNeeded() {
    if (usage_ < numCars_*Car::CAPACITY) {
        return;
    }

    if (type_ == BASIC) {
        size_changeSize(numCars_ + BASIC_SIZE_CHANGE);
    } else {
        size_changeSize(numCars_ * SMART_SIZE_CHANGE);
    }
}

void Train::downsizeIfNeeded() {
    if (numCars_ == 1) {
        // There is only one car and we cannot downsize to 0 cars.
        return;
    }
    if (type_ == BASIC && cars_[numCars_-1].isEmpty()) {
        size_changeSize(numCars_ - BASIC_SIZE_CHANGE);
    } else if (type_ == SMART
                && usage_ <= numCars_*Car::CAPACITY/SMART_DOWNSIZE_THRESHOLD) {
        size_changeSize(numCars_ / SMART_SIZE_CHANGE);
    }
}

void Train::printToStream(std::ostream& outStream) const {
    outStream << "(";
    outStream << revenue_;
    outStream << ", ";
    outStream << operatingCost_;
    outStream << ") ";
    for (size_t i = 0; i < numCars_; ++i) {
        outStream << cars_[i];
    }
}

std::ostream& operator<<(std::ostream& os, const Train& train) {
    train.printToStream(os);

    // To allow chaining of <<, we always return the stream we were given.
    return os;
}
