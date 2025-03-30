Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance |

    Ride class >> new: id pickup: pickup dropoff: dropoff distance: dist [
        ^ super new initialize: id pickup: pickup dropoff: dropoff distance: dist
    ]

    Ride >> initialize: id pickup: pickup dropoff: dropoff distance: dist [
        rideID := id.
        pickupLocation := pickup.
        dropoffLocation := dropoff.
        distance := dist.
    ]

    Ride >> fare [
        self subclassResponsibility
    ]

    Ride >> rideDetails [
        ^ 'Ride ID: ', rideID asString, ' | Pickup: ', pickupLocation, ' | Dropoff: ', dropoffLocation, ' | Distance: ', distance asString, ' miles.'
    ]
]

Ride subclass: StandardRide [
    StandardRide >> fare [
        ^ distance * 1.5
    ]

    StandardRide >> rideDetails [
        ^ super rideDetails, ' Fare: $', (self fare) asString, ' (Standard Ride)'
    ]
]

Ride subclass: PremiumRide [
    PremiumRide >> fare [
        ^ distance * 2.5
    ]

    PremiumRide >> rideDetails [
        ^ super rideDetails, ' Fare: $', (self fare) asString, ' (Premium Ride)'
    ]
]

Object subclass: Driver [
    | driverID name rating assignedRides |

    Driver class >> new: id name: nm rating: rtg [
        ^ super new initialize: id name: nm rating: rtg
    ]

    Driver >> initialize: id name: nm rating: rtg [
        driverID := id.
        name := nm.
        rating := rtg.
        assignedRides := OrderedCollection new.
    ]

    Driver >> addRide: ride [
        assignedRides add: ride.
    ]

    Driver >> getDriverInfo [
        ^ 'Driver ID: ', driverID asString, ' | Name: ', name, ' | Rating: ', rating asString, '\nAssigned Rides:\n', (assignedRides collect: [:r | r rideDetails]) join: '\n'
    ]
]

Object subclass: Rider [
    | riderID name requestedRides |

    Rider class >> new: id name: nm [
        ^ super new initialize: id name: nm
    ]

    Rider >> initialize: id name: nm [
        riderID := id.
        name := nm.
        requestedRides := OrderedCollection new.
    ]

    Rider >> requestRide: ride [
        requestedRides add: ride.
    ]

    Rider >> viewRides [
        ^ 'Rides for Rider ', name, ' (ID: ', riderID asString, '):\n', (requestedRides collect: [:r | r rideDetails]) join: '\n'
    ]
]

"Testing the system"
| rider1 driver1 ride1 ride2 |

rider1 := Rider new: 101 name: 'Alice'.
driver1 := Driver new: 201 name: 'Bob' rating: 4.9.
ride1 := StandardRide new: 1 pickup: 'A' dropoff: 'B' distance: 10.
ride2 := PremiumRide new: 2 pickup: 'C' dropoff: 'D' distance: 5.

rider1 requestRide: ride1.
rider1 requestRide: ride2.

driver1 addRide: ride1.
driver1 addRide: ride2.

Transcript show: rider1 viewRides; cr.
Transcript show: driver1 getDriverInfo; cr.
