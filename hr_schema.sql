
-- create the database
CREATE DATABASE hr;

-- switch to hR database;
USE hr;

/*
Regions Table
The Regions table stores information about the various global regions where the company operates.

Key Columns:
REGION_ID: 		The unique identifier for each region (primary key).
REGION_NAME: 	The name of the region (e.g., "Europe", "Asia", "Americas").
*/

CREATE TABLE REGIONS (
	REGION_ID		INT,
    REGION_NAME		VARCHAR(50),
    PRIMARY KEY 	PK_REGIONS (REGION_ID) -- NAME OF THE PRIMARY KEY CONSTRAINT IS PK_REGIONS
);

/*
Countries Table
The Countries table holds information about the countries where the company operates.

Key Columns:
COUNTRY_ID: 	The unique identifier for each country (primary key).
COUNTRY_NAME: 	The name of the country.
REGION_ID: 		Refers to the region in which the country is located (e.g., Europe, Asia, etc.). 
				This links to the Regions table.
*/
CREATE TABLE COUNTRIES (
	COUNTRY_ID 		VARCHAR(2),
    COUNTRY_NAME 	VARCHAR(40) ,
    REGION_ID 		INT,
    PRIMARY KEY 	PK_COUNTRIES (COUNTRY_ID)
);

/*
Locations Table
The Locations table contains information about the physical locations (offices or buildings) where the company operates.

Key Columns:
LOCATION_ID: 	The unique identifier for each location (primary key).
STREET_ADDRESS: The street address of the location.
POSTAL_CODE: 	The postal code of the location.
CITY: 			The city where the location is based.
STATE_PROVINCE: The state or province where the location is situated.
COUNTRY_ID: 	The country where the location is situated. This links to the Countries table.
*/

CREATE TABLE LOCATIONS (
	LOCATION_ID 		INT,
    STREET_ADDRESS 		VARCHAR(40),
    POSTAL_CODE 		VARCHAR(12),
    CITY 				VARCHAR(30),
    STATE_PROVINCE 		VARCHAR(25),
    COUNTRY_ID 			VARCHAR(2),
    PRIMARY KEY 		PK_LOCATIONS (LOCATION_ID)
);

/*
Departments Table
The Departments table contains information about the various departments within the organization.

Key Columns:
DEPARTMENT_ID: 		The unique identifier for each department (primary key).
DEPARTMENT_NAME: 	The name of the department (e.g., "Sales", "Marketing", "IT").
MANAGER_ID: 		The manager of the department. It refers to the EMPLOYEE_ID of the manager in the Employees table.
LOCATION_ID: 		The location where the department is situated. This links to the Locations table.
*/
CREATE TABLE DEPARTMENTS (
	DEPARTMENT_ID 		INT ,
    DEPARTMENT_NAME 	VARCHAR(30),
    MANAGER_ID 			INT,
    LOCATION_ID 		INT,
    PRIMARY KEY			PK_DEPARTMENTS (DEPARTMENT_ID)
);
/*
Jobs Table
The Jobs table contains details about the different job positions or titles in the organization.

Key Columns:
JOB_ID: 		The unique identifier for each job position (primary key).
JOB_TITLE: 		The title of the job position (e.g., "Software Engineer", "HR Manager").
MIN_SALARY: 	The minimum salary that can be earned in that job position.
MAX_SALARY: 	The maximum salary that can be earned in that job position.
*/
CREATE TABLE JOBS (
    JOB_ID 			VARCHAR(10),
    JOB_TITLE 		VARCHAR(35),
    MIN_SALARY 		DECIMAL(8, 2), -- MAX VALUE IS 99999999.99
    MAX_SALARY 		DECIMAL(8, 2),
    PRIMARY KEY		PK_JOBS (JOB_ID)
);

/*
Job History Table
The Job History table contains historical data about employees' job roles and changes over 
time within the organization.

Key Columns:
EMPLOYEE_ID: 	The ID of the employee whose job history is being recorded. This links to the Employees table.
START_DATE: 	The date when the employee started the job.
END_DATE: 		The date when the employee left the job or changed roles.
JOB_ID: 		The job ID associated with the employee during this period (links to the Jobs table).
DEPARTMENT_ID: 	The department in which the employee worked during this period (links to the Departments table).
*/
CREATE TABLE JOB_HISTORY (
    EMPLOYEE_ID 	INT,
    START_DATE 		DATE,
    END_DATE 		DATE,
    JOB_ID 			VARCHAR(10),
    DEPARTMENT_ID 	INT,
    PRIMARY KEY 	PK_JOB_HISTORY (EMPLOYEE_ID, START_DATE) -- COMPOSITE PRIMARY KEY
);

/*
Employees Table
The Employees table contains information about employees working in the organization.

Key Columns:
EMPLOYEE_ID: 	The unique identifier for each employee. This is the primary key of the table.
FIRST_NAME:
LAST_NAME: 		The employee's first and last names.
EMAIL: 			The employee's email address.
PHONE_NUMBER: 	The employee's contact number.
HIRE_DATE: 		The date when the employee joined the company.
JOB_ID: 		Refers to the job position assigned to the employee (e.g., 'IT_PROG' for IT Programmer).
SALARY: 		The employee's monthly or yearly salary.
COMMISSION_PCT: The percentage of commission the employee earns (if applicable).
MANAGER_ID: 	The ID of the employee's direct manager, which links to the EMPLOYEE_ID of the manager 
				in the same table (self-referencing relationship).
DEPARTMENT_ID: 	Refers to the department where the employee works. 
				This links to the DEPARTMENT_ID in the Departments table.
*/
CREATE TABLE EMPLOYEES (
    EMPLOYEE_ID 	INT,
    FIRST_NAME 		VARCHAR(20),
    LAST_NAME 		VARCHAR(25),
    EMAIL 			VARCHAR(25) ,
    PHONE_NUMBER 	VARCHAR(20),
    HIRE_DATE 		DATE,
    JOB_ID 			VARCHAR(10),
    SALARY 			DECIMAL(8, 2),
    COMMISSION_PCT 	DECIMAL(2, 2),
    MANAGER_ID 		INT,
    DEPARTMENT_ID 	INT,
    PRIMARY KEY 	PK_EMPLOYEES (EMPLOYEE_ID)  
);

/*
ALTER TABLES TO INCLUDE FOREIGN KEY 
*/

-- Add foreign key from Locations to Countries
ALTER TABLE LOCATIONS
ADD CONSTRAINT FK_Locations_Countries
FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES(COUNTRY_ID);

-- Add foreign key from Countries to Regions
ALTER TABLE COUNTRIES
ADD CONSTRAINT FK_Countries_Regions
FOREIGN KEY (REGION_ID) REFERENCES REGIONS(REGION_ID);

-- Add foreign key from Departments to Locations
ALTER TABLE DEPARTMENTS
ADD CONSTRAINT FK_Departments_Locations
FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS(LOCATION_ID);

-- Add foreign key from Departments to Employees (Manager)
ALTER TABLE DEPARTMENTS
ADD CONSTRAINT FK_Departments_Manager
FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID);

-- Add foreign key from Job_History to Employees
ALTER TABLE JOB_HISTORY
ADD CONSTRAINT FK_Job_History_Employees
FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID);

-- Add foreign key from Job_History to Jobs
ALTER TABLE JOB_HISTORY
ADD CONSTRAINT FK_Job_History_Jobs
FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID);

-- Add foreign key from Job_History to Departments
ALTER TABLE JOB_HISTORY
ADD CONSTRAINT FK_Job_History_Departments
FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID);

-- Add foreign key from Employees to Jobs
ALTER TABLE EMPLOYEES
ADD CONSTRAINT FK_Employees_Jobs
FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID);

-- Add foreign key from Employees to Departments
ALTER TABLE EMPLOYEES
ADD CONSTRAINT FK_Employees_Departments
FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID);

-- Add foreign key from Employees to Employees (self-referencing for Manager)
ALTER TABLE EMPLOYEES
ADD CONSTRAINT FK_Employees_Manager
FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID);
-------------------------------------------------------------------------------------
-- DML COMMANDS
-- Insert data into the Regions table
INSERT INTO REGIONS (REGION_ID, REGION_NAME) 
VALUES 
(1, 'Americas'),
(2, 'EMEA'),
(3, 'Asia');

-- Insert data into the Countries table
INSERT INTO COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID) 
VALUES 
('US', 'United States', 1),
('CA', 'Canada', 1),
('MX', 'Mexico', 1),
('GB', 'United Kingdom', 2),
('DE', 'Germany', 2),
('IN', 'India', 3),
('CN', 'China', 3),
('JP', 'Japan', 3);

-- Insert data into the Locations table
INSERT INTO LOCATIONS (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) 
VALUES 
(1000, '595 Market Street', '94105', 'San Francisco', 'CA', 'US'),
(1001, '2010 Hartree Way', '94105', 'Redwood City', 'CA', 'US'),
(1002, '1312 Park Blvd', '94043', 'Mountain View', 'CA', 'US'),
(1003, '35-23 Industrial Blvd', '90123', 'Berlin', 'BR', 'DE'),
(1004, '25 High Street', 'SW1A 2AA', 'London', 'LND', 'GB'),
(1005, '6000 Chidambaram Street', '60000', 'Mumbai', 'MH', 'IN'),
(1006, '7 Park Avenue', '10002', 'New York', 'NY', 'US'),
(1007, '46 Church Street', '20001', 'London', 'ENG', 'GB');

-- Insert data into the Jobs table
INSERT INTO JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) 
VALUES 
('AC_ACCOUNT', 'Public Accountant', 4200, 9000),
('AC_MGR', 'Accounting Manager', 8300, 17000),
('AD_ASST', 'Administration Assistant', 3000, 6000),
('AD_PRES', 'President', 20000, 40000),
('FI_ACCOUNT', 'Accountant', 4200, 9000),
('FI_MGR', 'Finance Manager', 7000, 15000),
('HR_REP', 'Human Resources Representative', 2500, 5500),
('IT_PROG', 'Programmer', 4000, 9000),
('MK_MAN', 'Marketing Manager', 5000, 12000),
('MK_REP', 'Marketing Representative', 2500, 6000),
('PR_REP', 'Public Relations Representative', 3500, 8500);

-- Insert data into the Employees table
INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES 
(100, 'Steven', 'King', 'SKING', '515.123.4567', TO_DATE('2007-06-09', 'YYYY-MM-DD'), 'AD_PRES', 24000, NULL, NULL, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', TO_DATE('2008-06-09', 'YYYY-MM-DD'), 'AD_VP', 17000, NULL, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', TO_DATE('2009-06-09', 'YYYY-MM-DD'), 'AD_VP', 17000, NULL, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '515.123.4570', TO_DATE('2010-06-09', 'YYYY-MM-DD'), 'IT_PROG', 9000, NULL, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '515.123.4571', TO_DATE('2011-06-09', 'YYYY-MM-DD'), 'IT_PROG', 6000, NULL, 103, 60),
(105, 'David', 'Austin', 'DAUSTIN', '515.123.4572', TO_DATE('2012-06-09', 'YYYY-MM-DD'), 'IT_PROG', 4800, NULL, 103, 60),
(106, 'Valli', 'Pataballa', 'VPATABAL', '515.123.4573', TO_DATE('2013-06-09', 'YYYY-MM-DD'), 'IT_PROG', 4800, NULL, 103, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '515.123.4574', TO_DATE('2014-06-09', 'YYYY-MM-DD'), 'IT_PROG', 4200, NULL, 103, 60),
(108, 'Nancy', 'Greenberg', 'NGREENBE', '515.123.4575', TO_DATE('2015-06-09', 'YYYY-MM-DD'), 'FI_MGR', 12000, NULL, 101, 100),
(109, 'Daniel', 'Faviet', 'DFAVIET', '515.123.4576', TO_DATE('2016-06-09', 'YYYY-MM-DD'), 'FI_ACCOUNT', 9000, NULL, 108, 100);

-- Insert data into the Departments table
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) 
VALUES 
(10, 'Administration', 100, 1000),
(20, 'IT', 103, 1001),
(30, 'Finance', 108, 1002),
(40, 'Marketing', 100, 1003),
(50, 'Public Relations', 100, 1004);

-- Insert data into the Job_History table
INSERT INTO JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) 
VALUES 
(103, TO_DATE('2007-01-01', 'YYYY-MM-DD'), TO_DATE('2010-01-01', 'YYYY-MM-DD'), 'IT_PROG', 60),
(104, TO_DATE('2007-01-01', 'YYYY-MM-DD'), TO_DATE('2010-01-01', 'YYYY-MM-DD'), 'IT_PROG', 60),
(105, TO_DATE('2008-01-01', 'YYYY-MM-DD'), TO_DATE('2011-01-01', 'YYYY-MM-DD'), 'IT_PROG', 60),
(106, TO_DATE('2009-01-01', 'YYYY-MM-DD'), TO_DATE('2012-01-01', 'YYYY-MM-DD'), 'IT_PROG', 60),
(107, TO_DATE('2009-01-01', 'YYYY-MM-DD'), TO_DATE('2013-01-01', 'YYYY-MM-DD'), 'IT_PROG', 60);

