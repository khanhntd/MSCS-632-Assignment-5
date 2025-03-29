#include <iostream>
#include <vector>
using namespace std;

// Base class Ride
class Ride {
    protected:
        int rideID;
        string pickupLocation;
        string dropoffLocation;
        double distance;
    public:
        Ride(int id, string pickup, string dropoff, double dist) : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist) {}
        virtual double fare() const = 0; // Pure virtual function
        virtual void rideDetails() const {
            cout << "Ride ID: " << rideID << "\nPickup: " << pickupLocation << "\nDropoff: " << dropoffLocation << "\nDistance: " << distance << " miles\n";
        }
        virtual ~Ride() {}
};

// Derived class StandardRide
class StandardRide : public Ride {
public:
    StandardRide(int id, string pickup, string dropoff, double dist) : Ride(id, pickup, dropoff, dist) {}
    double fare() const override { return distance * 1.5; } // Standard rate per mile
};

// Derived class PremiumRide
class PremiumRide : public Ride {
public:
    PremiumRide(int id, string pickup, string dropoff, double dist) : Ride(id, pickup, dropoff, dist) {}
    double fare() const override { return distance * 2.5; } // Premium rate per mile
};

// Driver class
class Driver {
    private:
        int driverID;
        string name;
        double rating;
        vector<Ride*> assignedRides;
    public:
        Driver(int id, string n, double r) : driverID(id), name(n), rating(r) {}
        void addRide(Ride* ride) { assignedRides.push_back(ride); }
        void getDriverInfo() const {
            cout << "Driver ID: " << driverID << "\nName: " << name << "\nRating: " << rating << "\nRides: " << assignedRides.size() << "\n";
        }
};

// Rider class
class Rider {
    private:
        int riderID;
        string name;
        vector<Ride*> requestedRides;
    public:
        Rider(int id, string n) : riderID(id), name(n) {}
        void requestRide(Ride* ride) { requestedRides.push_back(ride); }
        void viewRides() const {
            cout << "Rider: " << name << "\nRide History: \n";
            for (const auto& ride : requestedRides) {
                ride->rideDetails();
                cout << "Fare: $" << ride->fare() << "\n\n";
            }
        }
};

int main() {
    Rider rider(1, "Alice");
    Driver driver(101, "Bob", 4.9);

    Ride* ride1 = new StandardRide(1, "Downtown", "Airport", 10);
    Ride* ride2 = new PremiumRide(2, "Mall", "Stadium", 5);

    rider.requestRide(ride1);
    rider.requestRide(ride2);
    driver.addRide(ride1);
    driver.addRide(ride2);

    rider.viewRides();
    driver.getDriverInfo();

    delete ride1;
    delete ride2;
    return 0;
}
