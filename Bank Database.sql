-- Create Database
CREATE DATABASE BankDB;
USE BankDB;

-- Drop Foreign Key Constraints
SET FOREIGN_KEY_CHECKS = 0;

-- Customer Personal Information
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

-- Accounts information
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    AccountType VARCHAR(50),
    Balance DECIMAL(15, 2),
    OpenDate DATE
);

-- Transactions Information
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    TransactionType VARCHAR(50),
    Amount DECIMAL(15, 2),
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Branches Information
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY AUTO_INCREMENT,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(255),
    BranchPhoneNumber VARCHAR(15)
);

-- Account_Branch Table (Many-to-Many Relationship)
CREATE TABLE Account_Branch (
    AccountID INT,
    BranchID INT,
    PRIMARY KEY (AccountID, BranchID)
);

-- Re-apply Foreign Key Constraints
SET FOREIGN_KEY_CHECKS = 1;

-- Insert data into Customers
INSERT INTO Customers (FirstName, LastName, DateOfBirth, PhoneNumber, Email, Address)
VALUES 
('Mimusa', 'Azim', '1985-06-15', '018500', 'mimusaazim35@gmail.com', 'Chawkbazar, Chittagong'),
('Ishraq', 'Ahmed', '1990-08-25', '018700', 'ishraq.nibir@gmail.com', 'Dhanmondi, Dhaka'),
('Rahim', 'Haque', '1988-03-22', '555-4321', 'alice.johnson@example.com', '789 Birch Street'),
('Karim', 'Hossain', '1975-11-15', '555-8765', 'bob.brown@example.com', '321 Cedar Street'),
('Jasim', 'Akbar', '1992-07-30', '555-6789', 'carol.davis@example.com', '654 Willow Street'),
('Rafiq', 'Ahmeds', '1965-09-05', '555-2345', 'david.evans@example.com', '987 Spruce Street');

-- Insert data into Accounts
INSERT INTO Accounts (CustomerID, AccountType, Balance, OpenDate)
VALUES 
(1, 'Savings', 3000.00, '2023-03-01'),
(2, 'Checking', 1500.00, '2023-04-01'),
(3, 'Savings', 4000.00, '2023-05-01'),
(4, 'Checking', 2500.00, '2023-06-01'),
(5, 'Savings', 5000.00, '2023-07-01'),
(6, 'Checking', 3500.00, '2023-08-01');

-- Insert data into Transactions
INSERT INTO Transactions (AccountID, TransactionType, Amount)
VALUES 
(1, 'Deposit', 1200.00),
(3, 'Withdrawal', 300.00),
(4, 'Deposit', 2000.00),
(4, 'Withdrawal', 400.00),
(5, 'Withdrawal', 500.00),
(6, 'Deposit', 2500.00),
(6, 'Withdrawal', 700.00),
(7, 'Deposit', 1800.00),
(7, 'Withdrawal', 600.00),
(8, 'Deposit', 2200.00);

-- Insert data into Branches
INSERT INTO Branches (BranchName, BranchAddress, BranchPhoneNumber)
VALUES 
('Main Branch', 'Chawkbazar, Chittagong', '555-0001'),
('West Branch', 'Gulshan, Dhaka', '555-0002'),
('East Branch', '123 East Street', '555-0003'),
('North Branch', '456 North Street', '555-0004');

-- Insert into Account_Branch
INSERT INTO Account_Branch (AccountID, BranchID)
VALUES 
(3, 3),
(4, 3),
(5, 4),
(6, 4),
(7, 1),
(8, 2);

-- Retrieve All Customers
SELECT * FROM Customers;

-- Retrieve All Accounts with Customer Information
SELECT 
    Accounts.AccountID, 
    Accounts.AccountType, 
    Accounts.Balance, 
    Customers.FirstName, 
    Customers.LastName 
FROM 
    Accounts 
JOIN 
    Customers ON Accounts.CustomerID = Customers.CustomerID;

-- Retrieve All Transactions for a Specific Account
SELECT * FROM Transactions WHERE AccountID = 1;

-- Retrieve All Branches for a Specific Account
SELECT 
    Branches.BranchName, 
    Branches.BranchAddress 
FROM 
    Branches 
JOIN 
    Account_Branch ON Branches.BranchID = Account_Branch.BranchID 
WHERE 
    Account_Branch.AccountID = 1;
    
-- -- Retrieve All Branches informations
SELECT BranchName, BranchAddress, BranchPhoneNumber FROM Branches;

-- Retrieve the total balance of all accounts grouped by their types
SELECT AccountType, SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType;