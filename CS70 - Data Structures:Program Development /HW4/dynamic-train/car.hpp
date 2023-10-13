
#ifndef CAR_HPP_INCLUDED
#define CAR_HPP_INCLUDED

#include <ostream>
#include <cstddef>


class Car{
 public:
        static constexpr size_t CAPACITY = 4;

        Car();
        Car(const Car& other) = delete;
        Car& operator=(const Car& other) = delete;
        ~Car() = default;

        size_t getUsage() const;

        bool isEmpty() const;

        bool isFull() const;

        void addPackage();

        void removePackage();

        void printToStream(std::ostream& outStream) const;

 private:
        bool bins_[CAPACITY];

        size_t binsInUse_;
};

std::ostream& operator<<(std::ostream& os, const Car& c);

#endif
