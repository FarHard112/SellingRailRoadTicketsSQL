Selling Railroad Tickets - Database Design
This documentation describes the database design for managing the selling of railroad tickets. The system is comprised of several tables, triggers, and a stored procedure that collectively handle the various aspects of ticket selling.

Tables
1. Customers
Stores information about customers.

CustomerID: Primary Key
FirstName: Customer's First Name
LastName: Customer's Last Name
Email: Customer's Email Address
PhoneNumber: Customer's Phone Number
2. Trains
Contains details about trains.

TrainID: Primary Key
TrainName: Name of the Train
StartStation: Starting Station
EndStation: Ending Station
DepartureTime: Departure Time
ArrivalTime: Arrival Time
TotalSeats: Total Seats Available
AvailableSeats: Available Seats
3. Stations
Information about train stations.

StationID: Primary Key
StationName: Name of the Station
StationLocation: Location of the Station
OpeningHours: Opening Hours
4. Tickets
Manages ticket sales.

TicketID: Primary Key
CustomerID: Foreign Key to Customers
TrainID: Foreign Key to Trains
DateOfPurchase: Purchase Date
DepartureDate: Departure Date
SeatNumber: Seat Number
Price: Ticket Price
TicketStatus: Status of the Ticket (e.g., booked)
5. Routes
Contains details about train routes.

RouteID: Primary Key
TrainID: Foreign Key to Trains
StartStationID: Foreign Key to Stations (Start)
EndStationID: Foreign Key to Stations (End)
Duration: Duration of the Route
6. Payments
Stores information about ticket payments.

PaymentID: Primary Key
CustomerID: Foreign Key to Customers
TicketID: Foreign Key to Tickets
Amount: Payment Amount
PaymentDate: Payment Date
PaymentMethod: Payment Method
7. Discounts
Contains details about discounts.

DiscountID: Primary Key
Name: Name of the Discount
Amount: Discount Amount
ValidityStart: Validity Start Date
ValidityEnd: Validity End Date
8. Invoices
Generated invoices for tickets.

InvoiceID: Primary Key
InvoiceNumber: Invoice Number
TicketID: Foreign Key to Tickets
Amount: Invoice Amount
DateOfIssue: Invoice Issue Date
Triggers
1. trg_GenerateInvoices
Trigger that generates invoices when a new ticket is inserted.

Stored Procedures
1. sp_GetTicketDetails
Stored procedure to fetch detailed information about tickets including customer information and train details.

Sample Data Inserts
The script also includes inserts for sample data for testing purposes. The sample data corresponds to the structure of the tables.

Usage
Execute the provided SQL scripts in your SQL Server environment to create the tables, triggers, and stored procedures, and insert the sample data.

