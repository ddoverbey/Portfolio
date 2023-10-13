#ifndef TRAIN_HPP_INCLUDED
#define TRAIN_HPP_INCLUDED

#include <ostream>
#include <cstddef>

#include "car.hpp"

enum traintype { BASIC, SMART };

class Train{
 public:
        Train(traintype type);
        ~Train();

        Train() = delete;
        Train(const Train& other) = delete;
        Train operator=(const Train& other) = delete;

        void addPackage();
        void removePackage();
        void printToStream(std::ostream& outStream) const;

 private:
        Car* cars_;

        size_t numCars_;
        size_t usage_;

        double revenue_;
        double operatingCost_;

        static constexpr size_t BASIC_SIZE_CHANGE = 1;
        static constexpr size_t SMART_SIZE_CHANGE = 2;
        static constexpr size_t SMART_DOWNSIZE_THRESHOLD = 4;

        static constexpr double HANDLING_COST = 1.0;
        static constexpr double SHIPPING_COST = 4.0;

        traintype type_;

        void size_changeSize(size_t size);

        void upsizeIfNeeded();

        void downsizeIfNeeded();

        void loadPackage();
};

std::ostream& operator<<(std::ostream& os, const Train& c);

#endif

