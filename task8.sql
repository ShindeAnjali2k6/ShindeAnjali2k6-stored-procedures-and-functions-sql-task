-- task8.sql
-- Stored Procedures and Functions Demo

-- Drop procedure and function if exists (for repeat runs)
DROP PROCEDURE IF EXISTS GetCustomerOrders;
DROP FUNCTION IF EXISTS CalculateDiscount;

-- Sample Table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert Sample Data
INSERT INTO Customers (CustomerID, Name) VALUES (1, 'John Doe');
INSERT INTO Customers (CustomerID, Name) VALUES (2, 'Jane Smith');

INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (101, 1, 250.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (102, 1, 150.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (103, 2, 300.00);

-- Stored Procedure: GetCustomerOrders
DELIMITER //
CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)
BEGIN
    SELECT o.OrderID, o.Amount
    FROM Orders o
    WHERE o.CustomerID = cust_id;
END;
//
DELIMITER ;

-- Function: CalculateDiscount
DELIMITER //
CREATE FUNCTION CalculateDiscount(amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE discount DECIMAL(10,2);
    IF amount > 200 THEN
        SET discount = amount * 0.1; -- 10% discount
    ELSE
        SET discount = amount * 0.05; -- 5% discount
    END IF;
    RETURN discount;
END;
//
DELIMITER ;

-- How to Call Stored Procedure
CALL GetCustomerOrders(1);

-- How to Call Function
SELECT CalculateDiscount(250.00) AS DiscountAmount;
