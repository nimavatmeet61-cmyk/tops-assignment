create database contactmanagement;

use contactmanagement

CREATE TABLE Company (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10));

CREATE TABLE Contact (
    ContactID INT PRIMARY KEY,
    CompanyID INT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10),
    IsMain BOOLEAN,
    Email VARCHAR(45),
    Phone VARCHAR(12),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID));
   
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Salary DECIMAL(10,2),
    HireDate DATE,
    JobTitle VARCHAR(25),
    Email VARCHAR(45),
    Phone VARCHAR(12));
      
CREATE TABLE ContactEmployee (
    ContactEmployeeID INT PRIMARY KEY,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,
    Description VARCHAR(100),
    FOREIGN KEY (ContactID) REFERENCES Contact(ContactID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

 

INSERT INTO Employee (EmployeeID, FirstName, LastName, Salary, HireDate, JobTitle, Email, Phone)
VALUES 
(1, 'Lesley', 'Bland', 65000.00, '2020-06-12', 'Sales Manager', 'lesley.bland@marketco.com', '000-000-0000'),
(2, 'Michael', 'Turner', 72000.00, '2019-03-15', 'Marketing Lead', 'michael.turner@marketco.com', '215-555-7821'),
(3, 'Sophia', 'Nguyen', 58000.00, '2021-01-22', 'HR Coordinator', 'sophia.nguyen@marketco.com', '215-555-8920'),
(4, 'David', 'Carter', 80000.00, '2018-09-10', 'IT Manager', 'david.carter@marketco.com', '215-555-3344'),
(5, 'Emma', 'Johnson', 55000.00, '2022-04-05', 'Sales Associate', 'emma.johnson@marketco.com', '215-555-6699'),
(6, 'Ryan', 'Mitchell', 67000.00, '2020-11-18', 'Product Analyst', 'ryan.mitchell@marketco.com', '215-555-4433'),
(7, 'Olivia', 'Perez', 60000.00, '2021-06-30', 'Account Executive', 'olivia.perez@marketco.com', '215-555-7788'),
(8, 'Ethan', 'Brown', 75000.00, '2019-12-02', 'Finance Officer', 'ethan.brown@marketco.com', '215-555-2211');
select * from Employee;
 
INSERT INTO Company (CompanyID, CompanyName, Street, City, State, Zip)
VALUES
(1, 'Urban Outfitters, Inc.', '5000 Broad Street', 'Philadelphia', 'PA', '19112'),
(2, 'Toll Brothers', '250 Gibraltar Road', 'Horsham', 'PA', '19044'),
(3, 'Comcast Corporation', '1701 John F Kennedy Blvd', 'Philadelphia', 'PA', '19103'),
(4, 'Aramark', '2400 Market Street', 'Philadelphia', 'PA', '19103'),
(5, 'SAP America', '3999 West Chester Pike', 'Newtown Square', 'PA', '19073'),
(6, 'QVC', '1200 Wilson Drive', 'West Chester', 'PA', '19380'),
(7, 'Campbell Soup Company', '1 Campbell Place', 'Camden', 'NJ', '08103');
select * from company;
 
INSERT INTO ContactEvent (ContactEventID, ContactDate, Subject, Notes)
VALUES
(1, '2024-10-01', 'Quarterly Review', 'Discussed sales targets.'),
(2, '2024-10-05', 'Product Demo', 'Showcased new product features.'),
(3, '2024-10-10', 'Client Meeting', 'Follow-up on project deliverables.'),
(4, '2024-10-15', 'Budget Discussion', 'Talked about next quarter’s budget.'),
(5, '2024-10-20', 'Partnership Proposal', 'Explored partnership terms.');
select * from ContactEvent;

INSERT INTO ContactEmployee (ContactEmployeeID, ContactID, EmployeeID, ContactDate, Description)
VALUES
(1, 1, 1, '2024-02-10', 'Discussed potential partnership.'),
(2, 2, 3, '2024-03-15', 'Follow-up on contract details.'),
(3, 3, 2, '2024-05-05', 'Negotiated pricing terms.'),
(4, 4, 4, '2024-06-12', 'Scheduled onboarding training.'),
(5, 5, 5, '2024-07-18', 'Talked about renewal of agreement.'),
(6, 6, 6, '2024-08-20', 'Met about service improvements.'),
(7, 7, 2, '2024-09-01', 'Initial contact with Dianne Connor.'),
(8, 8, 1, '2024-09-22', 'Met with Toll Brothers for future collaboration.');



INSERT INTO ContactEmployee (ContactEmployeeID, ContactID, EmployeeID, ContactDate, Description)
VALUES (5, 5, 5, '2024-07-18', 'Talked about renewal of agreement.');
SELECT * FROM ContactEmployee;

INSERT INTO Company (CompanyID, CompanyName, Street, City, State, Zip)
VALUES
(1, 'Urban Outfitters', '1601 Market St', 'Philadelphia', 'PA', '19103'),
(2, 'Toll Brothers', '123 Main St', 'Philadelphia', 'PA', '19103'),
(3, 'Whole Foods Market', '200 Pine St', 'Austin', 'TX', '73301'),
(4, 'Comcast Corporation', '1800 JFK Blvd', 'Philadelphia', 'PA', '19103'),
(5, 'Amazon Studios', '410 Terry Ave', 'Seattle', 'WA', '98109'),
(6, 'Tesla Inc.', '3500 Deer Creek Rd', 'Palo Alto', 'CA', '94304'),
(7, 'Target Corporation', '1000 Nicollet Mall', 'Minneapolis', 'MN', '55403');

select City , count(*) as countz
from Company
group by City
having count(*)>=3;

INSERT IGNORE INTO Contact
(ContactID, CompanyID, FirstName, LastName, Street, City, State, Zip, IsMain, Email, Phone)
VALUES
(1, 1, 'Dianne', 'Connor', '22 North St', 'Philadelphia', 'PA', '19103', TRUE, 'dianne.connor@urban.com', '215-555-8800'),
(2, 2, 'John', 'Doe', '123 Main St', 'Philadelphia', 'PA', '19103', TRUE, 'john.doe@tollbrothers.com', '215-555-8899'),
(3, 3, 'Emma', 'Smith', '200 Pine St', 'Austin', 'TX', '73301', TRUE, 'emma.smith@wholefoods.com', '512-555-7000'),
(4, 4, 'Michael', 'Brown', '125 Main St', 'Philadelphia', 'PA', '19103', FALSE, 'michael.b@comcast.com', '215-555-8898'),
(5, 5, 'Sana', 'Ali', '18 Market St', 'Seattle', 'WA', '98109', FALSE, 'sana.ali@amazon.com', '206-555-8801'),
(6, 6, 'Laura', 'Green', '350 Deer Creek Rd', 'Palo Alto', 'CA', '94304', FALSE, 'laura.green@tesla.com', '650-555-8897'),
(7, 7, 'Carlos', 'Diaz', '1000 Nicollet Mall', 'Minneapolis', 'MN', '55403', FALSE, 'carlos.d@target.com', '612-555-7001');


INSERT INTO ContactEmployee 
(ContactEmployeeID, ContactID, EmployeeID, ContactDate, Description)
VALUES
(9, 2, 2, '2024-09-22', 'Sophia met John Doe at Toll Brothers'),
(10, 2, 3, '2024-09-25', 'Jack met John Doe at Toll Brothers');

UPDATE Employee
SET Phone = '215-555-8800'
WHERE EmployeeID = 1;
select * from Employee;

UPDATE Company
SET CompanyName = 'Urban Outfitters'
WHERE CompanyID = 1;
select * from company;

DELETE FROM ContactEmployee
WHERE ContactEmployeeID = 7;
select * from ContactEmployee;

SELECT e.FirstName, e.LastName
FROM Employee e
JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
JOIN Contact c ON ce.ContactID = c.ContactID
JOIN Company co ON c.CompanyID = co.CompanyID
WHERE co.CompanyName = 'Toll Brothers';

SELECT * FROM Employee
WHERE FirstName LIKE 'S%';

SELECT * FROM Employee
WHERE FirstName LIKE '_____';


---------------------------------------------------   THEORY QUE AND ANS ---------------------------------------------------------------------------


Q8  ---- Meaning of “%” and “_” in LIKE

| Symbol | Meaning                                            
| ------ | -------------------------------------------------- 
| `%`    | Matches **any sequence of characters** (0 or more) 
| `_`    | Matches **exactly one character**                  



Q9 --- Explain normalization in the context of databases.

      Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity.
	  It involves dividing large tables into smaller related ones and defining relationships between them.

    Common normal forms:

	1NF: Remove repeating groups.
	2NF: Remove partial dependencies.
	3NF: Remove transitive dependencies.
	

Q10 ---  Meaning of JOIN in MySQL


LEFT JOIN: Returns all rows from the left table + matching rows from the right.
RIGHT JOIN: Returns all rows from the right table + matching rows from the left.
OUTER JOIN: Combines left and right joins.
CROSS JOIN: Returns all possible combinations.

SELECT e.FirstName, e.LastName, ce.Description
FROM Employee e
JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
JOIN Contact c ON ce.ContactID = c.ContactID;


Q11 -- Difference between DDL, DCL, and DML

 
| Type    | Full Form                  | Purpose                         | Examples                               |
| ------- | -------------------------- | ------------------------------- | -------------------------------------- |
| **DDL** | Data Definition Language   | Defines structure of DB objects | `CREATE`, `ALTER`, `DROP`, `TRUNCATE`  |
| **DML** | Data Manipulation Language | Manages data inside tables      | `SELECT`, `INSERT`, `UPDATE`, `DELETE` |
| **DCL** | Data Control Language      | Controls access to data         | `GRANT`, `REVOKE`                      |



Q12 ---What is the role of the MySQL JOIN clause in a query, and what are some common types of joins?

The JOIN clause is used to retrieve data from multiple tables by matching related columns.

Common types of joins:
INNER JOIN: Returns matching rows from both tables.
LEFT JOIN: Returns all rows from the left table, and matched rows from the right table.
RIGHT JOIN: Returns all rows from the right table, and matched rows from the left table.
FULL OUTER JOIN: Returns all rows when there is a match in either table (not directly supported in MySQL, can be simulated).
CROSS JOIN: Returns the Cartesian product of both tables.