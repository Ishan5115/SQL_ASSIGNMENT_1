/* IMPORTANT INSTRUCTIONS FOR LEARNERS
1) DO NOT CHANGE THE ORDER OF COLUMNS.
2) YOUR QUERY SHOULD DISPLAY COLUMNS IN THE SAME ORDER AS MENTIONED IN ALL QUESTIONS.
3) YOU CAN FIND THE ORDER OF COLUMNS IN QUESTION TEMPLATE SECTION OF EACH QUESTION.
4) USE ALIASING AS MENTIONED IN QUESTION TEMPLATE FOR ALL COLUMNS
5) DO NOT CHANGE COLUMN NAMES*/
                   
-- Question 1 (Marks: 2)
-- Objective: Retrieve data using basic SELECT statements
-- List the names of all customers in the database.
-- Question Template: Display CustomerName Column

-- Write your SQL solution here
use northwind;
SELECT 
    CustomerName
FROM
    customers;

-- Question 2 (Marks: 2)
-- Objective: Apply filtering using the WHERE clause
-- Retrieve the names and prices of all products that cost less than $15.
-- Question Template: Display ProductName Column

SELECT 
    productId, ProductName, Price
FROM
    products
WHERE
    price < 15
ORDER BY price DESC;

-- Question 3 (Marks: 2)
-- Objective: Use SELECT to extract multiple fields
-- Display all employees first and last names.
-- Question Template: Display FirstName, LastName Columns

SELECT 
    FirstName, LastName
FROM
    employees;
    
-- Question 4 (Marks: 2)
-- Objective: Filter data using a function on date values
-- List all orders placed in the year 1997.
-- Question Template: Display OrderID, OrderDate Columns

SELECT 
    OrderId, OrderDate
FROM
    orders
WHERE
    OrderDate >= '1997-01-01';
    
-- Question 5 (Marks: 2)
-- Objective: Apply numeric filters
-- List all products that have a price greater than $50.
-- Question Template: Display ProductName, Price Column

SELECT 
    ProductId, productName, Price
FROM
    products
WHERE
    price > 50
ORDER BY price DESC;

-- Question 6 (Marks: 3)
-- Objective: Perform multi-table JOIN operations
-- Show the names of customers and the names of the employees who handled their orders.
-- Question Template: Display CustomerName, FirstName, LastName Columns

SELECT 
    c.CustomerName, e.FirstName, e.LastName
FROM
    employees e
        JOIN
    orders o ON e.EmployeeID = o.EmployeeID
        JOIN
    customers c ON o.CustomerID = c.CustomerID;
    
-- Question 7 (Marks: 3)
-- Objective: Use GROUP BY for aggregation
-- List each country along with the number of customers from that country.
-- Question Template: Display Country, CustomerCount Columns

SELECT 
    Country, COUNT(CustomerName) AS CustomerCount
FROM
    customers
GROUP BY Country;
-- Question 8 (Marks: 3)
-- Objective: Group data by a foreign key relationship and apply aggregation
-- Find the average price of products grouped by category.
-- Question Template: Display CategoryName, AvgPrice Columns

SELECT 
    c.CategoryName, AVG(p.Price) AS AVERAGE_PRICE
FROM
    products p
        JOIN
    categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName;

-- Question 9 (Marks: 3)
-- Objective: Use aggregation to count records per group
-- Show the number of orders handled by each employee.
-- Question Template: Display EmployeeID, OrderCount Columns

SELECT 
    EmployeeID, COUNT(*) AS OrderCount
FROM
    orders
GROUP BY EmployeeID;

-- Question 10 (Marks: 3)
-- Objective: Filter results using values from a joined table
-- List the names of products supplied by "Exotic Liquids".
-- Question Template: Display ProductName Column

SELECT 
    p.ProductName
FROM
    products p
        JOIN
    suppliers s ON p.SupplierID = s.SupplierId
WHERE
    s.SupplierName = 'Exotic Liquid';
    
-- Question 11 (Marks: 5)
-- Objective: Rank records using aggregation and sort
-- List the top 3 most ordered products (by quantity).
-- Question Template: Display ProductID, TotalOrdered Columns

SELECT 
    od.ProductId, SUM(od.Quantity) AS TotalOrdered
FROM
    orderdetails od
GROUP BY od.ProductID
ORDER BY TotalOrdered DESC
LIMIT 3;

-- Question 12 (Marks: 5)
-- Objective: Use GROUP BY and HAVING to filter on aggregates
-- Find customers who have placed orders worth more than $10,000 in total.
-- Question Template: Display CustomerName, TotalSpent Columns

SELECT 
    c.CustomerName, SUM(p.Price * od.Quantity) AS TotalSpent
FROM
    customers c
        JOIN
    orders o ON c.CustomerID = o.CustomerID
        JOIN
    orderdetails od ON o.OrderID = od.OrderID
        JOIN
    products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerID , c.CustomerName
HAVING SUM(p.Price * od.Quantity) > 10000;

-- Question 13 (Marks: 5)
-- Objective: Aggregate and filter at the order level
-- Display order IDs and total order value for orders that exceed $2,000 in value.
-- Question Template: Display OrderID, OrderValue Columns

SELECT 
    o.OrderID, SUM(Od.Quantity * p.Price) AS OrderValue
FROM
    orders o
        JOIN
    orderdetails od ON o.OrderID = od.OrderID
        JOIN
    products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID
HAVING SUM(Od.Quantity * p.Price) > 2000;

-- Question 14 (Marks: 5)
-- Objective: Use subqueries in HAVING clause
-- Find the name(s) of the customer(s) who placed the largest single order (by value).
-- Question Template: Display CustomerName, OrderID, TotalValue Column

SELECT 
    c.CustomerName,
    o.OrderID,
    SUM(p.Price * od.Quantity) AS TotalValue
FROM
    customers c
        JOIN
    orders o ON c.CustomerID = o.CustomerID
        JOIN
    orderdetails od ON o.OrderID = od.OrderID
        JOIN
    products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerName , o.OrderID
HAVING SUM(od.Quantity * p.Price) = (SELECT 
        MAX(TotalOrderValue)
    FROM
        (SELECT 
            SUM(od.Quantity * p.Price) AS TotalOrderValue
        FROM
            OrderDetails od
        JOIN Products p ON od.ProductID = p.ProductID
        GROUP BY od.OrderID) AS OrderTotals);
    
-- Question 15 (Marks: 5)
-- Objective: Identify records using NOT IN with subquery
-- Get a list of products that have never been ordered.
-- Question Template: Display ProductName Columns

SELECT 
    ProductName
FROM
    Products
WHERE
    ProductID NOT IN (SELECT DISTINCT
            ProductID
        FROM
            OrderDetails);




