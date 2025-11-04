-- ✅ Select  database create
CREATE DATABASE bank;
USE bank;

-- 🧍 Customers table - main personal and financial details
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,              -- Unique ID for each customer
  name VARCHAR(100),                        -- Customer's full name
  gender ENUM('Male','Female'),             -- Gender classification
  age INT,                                  -- Used for risk and age-based analysis
  geography VARCHAR(50),                    -- Country or region
  credit_score INT,                         -- Important metric for loan eligibility
  balance DECIMAL(12,2),                    -- Account balance for liquidity analysis
  estimated_salary DECIMAL(12,2),           -- For income-based analysis
  is_active_member TINYINT(1),              -- 1 = active, 0 = inactive
  churned TINYINT(1)                        -- 1 = left bank, 0 = retained
);

-- 💳 Accounts table - links customer to banking product
CREATE TABLE accounts (
  account_id INT PRIMARY KEY,
  customer_id INT,
  account_type ENUM('Savings','Current','Business'),
  created_at DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 💰 Transactions table - logs deposits/withdrawals
CREATE TABLE transactions (
  transaction_id INT PRIMARY KEY,
  account_id INT,
  amount DECIMAL(12,2),
  transaction_type ENUM('Deposit','Withdrawal','Transfer'),
  transaction_date DATE,
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- 🏦 Loans table - details about customer borrowing
CREATE TABLE loans (
  loan_id INT PRIMARY KEY,
  customer_id INT,
  loan_type ENUM('Personal','Business','Mortgage','Auto'),
  loan_amount DECIMAL(12,2),
  interest_rate DECIMAL(5,2),
  loan_status ENUM('Approved','Pending','Defaulted'),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 🧾 Audit Log - tracks data changes
CREATE TABLE audit_log (
  log_id INT PRIMARY KEY AUTO_INCREMENT,
  table_name VARCHAR(50),
  operation VARCHAR(10),
  changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  details TEXT
);
-- 🧍 Insert sample customers
INSERT INTO customers (customer_id, name, gender, age, geography, credit_score, balance, estimated_salary, is_active_member, churned)
VALUES
(1, 'John Doe', 'Male', 35, 'Kenya', 720, 35000.00, 120000.00, 1, 0),
(2, 'Mary Wanjiku', 'Female', 29, 'Kenya', 680, 25000.00, 80000.00, 1, 0),
(3, 'Ali Mwangi', 'Male', 42, 'Tanzania', 590, 10000.00, 60000.00, 0, 1),
(4, 'Jane Achieng', 'Female', 31, 'Uganda', 710, 50000.00, 150000.00, 1, 0),
(5, 'Brian Otieno', 'Male', 26, 'Kenya', 650, 8000.00, 50000.00, 0, 1);
SELECT * FROM customers;

-- Insert account details for each customer
INSERT INTO accounts (account_id, customer_id, account_type, created_at)
VALUES
(101, 1, 'Savings', '2020-05-12'),
(102, 2, 'Current', '2021-01-20'),
(103, 3, 'Business', '2019-03-15'),
(104, 4, 'Savings', '2022-06-10'),
(105, 5, 'Current', '2023-01-05');
SELECT * FROM accounts;

-- Insert transactions linked to the accounts
INSERT INTO transactions (transaction_id, account_id, amount, transaction_type, transaction_date)
VALUES
(1001, 101, 5000.00, 'Deposit', '2024-01-10'),
(1002, 101, 2000.00, 'Withdrawal', '2024-02-12'),
(1003, 102, 15000.00, 'Deposit', '2024-03-05'),
(1004, 103, 10000.00, 'Transfer', '2024-04-01'),
(1005, 104, 25000.00, 'Deposit', '2024-04-15');
SELECT * FROM transactions;

-- 🏦 Loans
INSERT INTO loans (loan_id, customer_id, loan_type, loan_amount, interest_rate, loan_status)
VALUES
(201, 1, 'Personal', 50000.00, 12.5, 'Approved'),
(202, 2, 'Mortgage', 250000.00, 10.0, 'Approved'),
(203, 3, 'Auto', 120000.00, 14.0, 'Defaulted'),
(204, 4, 'Personal', 70000.00, 13.0, 'Pending'),
(205, 5, 'Business', 200000.00, 15.0, 'Approved');

SELECT 
  (SELECT COUNT(*) FROM customers) AS customers_count,
  (SELECT COUNT(*) FROM accounts) AS accounts_count,
  (SELECT COUNT(*) FROM transactions) AS transactions_count,
  (SELECT COUNT(*) FROM loans) AS loans_count;
SELECT user, host FROM mysql.user;

CREATE USER 'weldon'@'%' IDENTIFIED BY 'xxxxxxx';
SELECT user, host FROM mysql.user;
ALTER USER 'weldon'@'%' IDENTIFIED BY 'xxxxxxxxxxx';
GRANT ALL PRIVILEGES ON bank.* TO 'xxxxxxxx;


FLUSH PRIVILEGES;




