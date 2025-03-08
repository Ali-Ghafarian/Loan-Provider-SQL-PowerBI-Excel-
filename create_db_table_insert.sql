-- Create a new database called 'db_bank_loan'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'db_bank_loan'
)
CREATE DATABASE db_bank_loan
GO
-- Connect to the new database
USE db_bank_loan
GO
-- Create a new table called 'bank_loan_data'
-- This table will store data related to bank loans
CREATE TABLE bank_loan_data (
    id INT PRIMARY KEY,
    address_state CHAR(2),
    application_type VARCHAR(50),
    emp_length VARCHAR(20),
    emp_title VARCHAR(100),
    grade CHAR(1),
    home_ownership VARCHAR(20),
    issue_date VARCHAR(50),
    last_credit_pull_date VARCHAR(50),
    last_payment_date VARCHAR(50),
    loan_status VARCHAR(50),
    next_payment_date VARCHAR(50),
    member_id INT,
    purpose VARCHAR(50),
    sub_grade VARCHAR(2),
    term VARCHAR(20),
    verification_status VARCHAR(50),
    annual_income DECIMAL(15,2),
    dti DECIMAL(10,4),
    installment DECIMAL(15,2),
    int_rate DECIMAL(6,4),
    loan_amount INT,
    total_acc INT,
    total_payment INT
)
GO

-- Bulk load data from the CSV file into bank_loan_data table
BULK INSERT bank_loan_data
FROM '/tmp/financial_loan.csv'
WITH (
    FIRSTROW = 2,                   -- Skip header row
    FIELDTERMINATOR = ',',          -- Field delimiter
    ROWTERMINATOR = '0x0a',         -- Row delimiter (line feed)
    TABLOCK                       -- Improve performance during bulk load
)
GO
