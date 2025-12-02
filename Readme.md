==============================================
                 DATA MODELING REPORT
   (Facts and Dimensions + Query Thinking Framework)
============================================================

1) WHAT IS DATA MODELING?
------------------------------------------------------------
Data modeling is organizing data into logical tables so queries
are easy, fast, and meaningful.

ANALOGY:
  Books   -> bookshelf
  Clothes -> cupboard
  Data    -> tables

------------------------------------------------------------
2) FACT TABLE vs DIMENSION TABLE
------------------------------------------------------------

FACT TABLE (Numbers and Events)

A fact table stores measurable business data like:
  - Sales
  - Revenue
  - Quantity
  - Clicks
  - Transactions

Example: fact_sales

Typical columns:
  sale_id
  customer_id
  product_id
  date_id
  quantity
  amount

FACT TABLE answers:
  "What happened and how much?"

------------------------------------------------------------

DIMENSION TABLE (Details and Description)

Dimension tables store descriptive information:
  - Who
  - What
  - When
  - Where

Example dimension tables:

dim_customer:
  customer_id
  name
  city

dim_product:
  product_id
  name
  category

dim_date:
  date_id
  year
  month
  day

DIMENSION TABLE answers:
  "More information about the fact"

------------------------------------------------------------
3) WHY DO WE SEPARATE FACT & DIMENSION?
------------------------------------------------------------

If everything is in one table:
  - Data is repeated
  - Maintenance is difficult
  - Queries become slow
  - Errors increase

If fact and dimension are separate:
  - Design is clean
  - Analysis becomes easy
  - Performance improves
  - Duplication is reduced

------------------------------------------------------------
4) STAR SCHEMA
------------------------------------------------------------

A fact table is in the center.
Dimensions are connected to the fact table.

The fact table connects to:
  - Customer dimension
  - Product dimension
  - Date dimension
  - Store dimension

This design is called STAR SCHEMA.

------------------------------------------------------------
5) MOST IMPORTANT RULE
------------------------------------------------------------

ALWAYS START FROM THE FACT TABLE.

  Numbers live in fact tables.
  Details live in dimension tables.

------------------------------------------------------------
6) THINKING PROCESS FOR ANY QUERY
------------------------------------------------------------

STEP 1: Identify the NUMBER
  - SUM
  - COUNT
  - AVG
  - MAX
  - MIN

Example:
  "Total Sales" -> SUM(amount)

STEP 2: Find the FACT table
  - Fact tables store amounts and metrics.

Example:
  FROM fact_sales

STEP 3: Identify required DIMENSIONS
  - City      -> dim_customer
  - Category  -> dim_product
  - Month     -> dim_date

STEP 4: Apply GROUPING
  Look for words like:
    by
    per
    for each

Example:
  GROUP BY city

STEP 5: Apply FILTERS (if needed)
  Look for:
    specific year
    specific city
    specific category

Example:
  WHERE year = 2024

------------------------------------------------------------
7) MASTER QUERY TEMPLATE
------------------------------------------------------------

SELECT required columns
FROM   fact_table
JOIN   dimension_table(s)
WHERE  filter conditions
GROUP  BY grouping columns
ORDER  BY sorting columns

------------------------------------------------------------
8) COMMON MISTAKES TO AVOID
------------------------------------------------------------

  - Do not store names in fact tables
  - Do not store totals in dimension tables
  - Always use a date dimension
  - Always define grain
  - Avoid using text as primary keys

------------------------------------------------------------
9) IMPORTANT CONCEPT: GRAIN
------------------------------------------------------------

Grain = What one row represents

Examples:
  - One row per sale
  - One row per day
  - One row per product per order

If grain is wrong -> results are wrong.

------------------------------------------------------------
10) FACT vs DIMENSION RECOGNITION
------------------------------------------------------------

Amount     -> Fact
City       -> Dimension
Quantity   -> Fact
Year       -> Dimension
Revenue    -> Fact
Category   -> Dimension

Some Outputs :
<img width="1440" height="900" alt="Screenshot 2025-12-02 at 12 28 55 PM" src="https://github.com/user-attachments/assets/0ca7f636-c453-40b0-9cf9-e0c900f2acf1" />

<img width="1440" height="900" alt="Screenshot 2025-12-02 at 12 29 26 PM" src="https://github.com/user-attachments/assets/16fda256-8b60-476c-b937-77d48d2fcaa5" />



==============================================
               SQL MULTIPLE JOINS REPORT
             (Concepts + Thinking + Code)
============================================================

1) WHAT IS A JOIN?
------------------------------------------------------------
A JOIN combines rows from two or more tables using a common column.

Example:
  customer_id links customers and orders
  product_id  links order_items and products

------------------------------------------------------------
2) WHAT IS A MULTIPLE JOIN?
------------------------------------------------------------
Joining MORE THAN TWO TABLES in one query is called MULTIPLE JOIN.

Example path:
  customers -> orders -> order_items -> products

------------------------------------------------------------
3) WHY MULTIPLE JOINS ARE NEEDED
------------------------------------------------------------

Real data lives in separate tables.
A single table never contains all information.

To answer:
  "Who bought what?"

You must join many tables.

------------------------------------------------------------
4) TYPES OF JOINS
------------------------------------------------------------

INNER JOIN = Only matching rows
LEFT JOIN  = All from left table + matches
RIGHT JOIN = All from right table + matches
FULL JOIN  = Everything from both sides
CROSS JOIN = Every combination

------------------------------------------------------------
5) GOLDEN RULE
------------------------------------------------------------

LEFT table controls result in LEFT JOIN.
RIGHT table controls result in RIGHT JOIN.

------------------------------------------------------------
6) THINKING PROCESS FOR MULTIPLE JOINS
------------------------------------------------------------

STEP 1: Start from base table
STEP 2: Identify next related table
STEP 3: Find join key
STEP 4: Decide join type
STEP 5: Repeat until you reach required data

------------------------------------------------------------
7) SIMPLE RELATION SCHEMA
------------------------------------------------------------

customers
  customer_id
  name

orders
  order_id
  customer_id

order_items
  order_id
  product_id

products
  product_id
  name
  price


------------------------------------------------------------
8) COMMON MISTAKES
------------------------------------------------------------

Joining without condition  -> Cartesian explosion
Wrong key                 -> Wrong data
Using INNER instead LEFT  -> Missing rows
Too many columns selected -> Confusion
No aliases                -> Hard to read

------------------------------------------------------------
9) DEBUGGING STRATEGY
------------------------------------------------------------

If results look wrong:

1) Run each JOIN separately.
2) Count records after each join.
3) Verify keys.
4) Validate duplicates.
5) Switch join types to test.

------------------------------------------------------------
10) ONE LINE INTERVIEW ANSWER
------------------------------------------------------------

Multiple joins link normalized tables to reconstruct business
meaning across datasets. Nested joins improve readability and
logic decomposition.

<img width="1440" height="900" alt="Screenshot 2025-12-02 at 12 35 47 PM" src="https://github.com/user-attachments/assets/8393cb89-735e-4b69-9923-73280d31d7c0" />

<img width="1440" height="900" alt="Screenshot 2025-12-02 at 12 36 01 PM" src="https://github.com/user-attachments/assets/492ab9a1-83d7-4e87-b644-bdfa16b02e95" />

