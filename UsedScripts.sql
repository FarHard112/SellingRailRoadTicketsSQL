CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15)
);

CREATE TABLE Trains (
    TrainID INT PRIMARY KEY,
    TrainName VARCHAR(100),
    StartStation INT,
    EndStation INT,
    DepartureTime DATETIME,
    ArrivalTime DATETIME,
    TotalSeats INT,
    AvailableSeats INT
);

CREATE TABLE Stations (
    StationID INT PRIMARY KEY IDENTITY(1,1),
    StationName VARCHAR(100),
    StationLocation VARCHAR(100),
    OpeningHours VARCHAR(50)
);

CREATE TABLE Tickets (
    TicketID INT PRIMARY  KEY IDENTITY(1,1),
    CustomerID INT,
    TrainID INT,
    DateOfPurchase DATETIME,
    DepartureDate DATETIME,
    SeatNumber INT,
    Price DECIMAL(10, 2),
    TicketStatus VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (TrainID) REFERENCES Trains(TrainID)
);

CREATE TABLE Routes (
    RouteID INT PRIMARY KEY IDENTITY(1,1),
    TrainID INT,
    StartStationID INT,
    EndStationID INT,
    Duration INT,
    FOREIGN KEY (TrainID) REFERENCES Trains(TrainID),
    FOREIGN KEY (StartStationID) REFERENCES Stations(StationID),
    FOREIGN KEY (EndStationID) REFERENCES Stations(StationID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    TicketID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATETIME,
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID)
);

CREATE TABLE Discounts (
    DiscountID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Amount DECIMAL(10, 2),
    ValidityStart DATETIME,
    ValidityEnd DATETIME
);


INSERT INTO Stations (StationName, StationLocation, OpeningHours) VALUES ('Station A', 'City A', '06:00-22:00');
INSERT INTO Stations (StationName, StationLocation, OpeningHours) VALUES ('Station B', 'City B', '05:00-23:00');

INSERT INTO Trains (TrainName, StartStation, EndStation, DepartureTime, ArrivalTime, TotalSeats, AvailableSeats) VALUES ('Train X', 1, 2, '2023-08-05 08:00', '2023-08-05 12:00', 100, 90);

INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber) VALUES ('Farhad', 'Mammadov', 'farhadmdovv@vmedia.ca', '1234567890');


INSERT INTO Tickets (CustomerID, TrainID, DateOfPurchase, DepartureDate, SeatNumber, Price, TicketStatus) VALUES (1, 1, '2023-08-02 14:00', '2023-08-05 08:00', 10, 50.00, 'booked');

INSERT INTO Routes (TrainID, StartStationID, EndStationID, Duration) VALUES (1, 1, 2, 240);

INSERT INTO Payments (CustomerID, TicketID, Amount, PaymentDate, PaymentMethod) VALUES (1, 1, 50.00, '2023-08-02 14:00', 'credit card');

INSERT INTO Discounts (Name, Amount, ValidityStart, ValidityEnd) VALUES ('Summer Sale', 10.00, '2023-06-01', '2023-08-31');

CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY IDENTITY(1,1),
    InvoiceNumber NVARCHAR(10),
    TicketID INT,
    Amount DECIMAL(10, 2),
    DateOfIssue DATETIME,
    FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID)
);


CREATE TRIGGER trg_GenerateInvoices
ON Tickets
AFTER INSERT
AS
BEGIN
    DECLARE @ticketID INT, @invoiceNumber NVARCHAR(10), @price DECIMAL(10, 2), @maxInvoiceID INT

    SELECT @ticketID = TicketID, @price = Price FROM INSERTED

    SELECT @maxInvoiceID = MAX(InvoiceID) FROM Invoices

    SET @invoiceNumber = 'SRRT-' + RIGHT('000' + CAST((ISNULL(@maxInvoiceID, 0) + 1) AS NVARCHAR), 4)

    INSERT INTO Invoices (InvoiceNumber, TicketID, Amount, DateOfIssue) VALUES (@invoiceNumber, @ticketID, @price, GETDATE())
END


INSERT INTO Tickets (CustomerID, TrainID, DateOfPurchase, DepartureDate, SeatNumber, Price, TicketStatus)
VALUES (1, 1, '2023-08-02 14:00', '2023-08-05 08:00', 10, 50.00, 'booked');
Select * from Tickets


CREATE PROCEDURE sp_GetTicketDetails
AS
BEGIN
    SELECT 
        t.TicketID,
        c.FirstName+' '+c.LastName as FullName,
        tr.TrainName,
        t.DateOfPurchase,
        t.DepartureDate,
        t.SeatNumber,
        t.Price,
        t.TicketStatus AS TicketStatus
    FROM Tickets t
    INNER JOIN Customers c ON t.CustomerID = c.CustomerID
	INNER JOIN Trains tr on tr.TrainID=t.TrainID
END


EXEC sp_GetTicketDetails