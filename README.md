# Oracle HR Schema

## 1. Employees Table
This table contains details about employees in the organization.

| Column Name       | Description                                  |
|-------------------|----------------------------------------------|
| EMPLOYEE_ID       | Unique identifier for the employee           |
| FIRST_NAME        | Employee's first name                        |
| LAST_NAME         | Employee's last name                         |
| EMAIL             | Employee's email address                     |
| PHONE_NUMBER      | Employee's phone number                      |
| HIRE_DATE         | Date when the employee was hired             |
| JOB_ID            | Job identifier (e.g., 'IT_PROG')             |
| SALARY            | Employee's salary                            |
| COMMISSION_PCT    | Commission percentage                        |
| MANAGER_ID        | ID of the employee's manager                 |
| DEPARTMENT_ID     | ID of the department the employee works in   |

## 2. Departments Table
This table stores information about the various departments in the organization.

| Column Name       | Description                                  |
|-------------------|----------------------------------------------|
| DEPARTMENT_ID     | Unique identifier for the department         |
| DEPARTMENT_NAME   | Name of the department                       |
| MANAGER_ID        | ID of the department manager                 |
| LOCATION_ID       | ID of the location where the department is located |

## 3. Jobs Table
This table stores information about different job positions available in the organization.

| Column Name       | Description                                  |
|-------------------|----------------------------------------------|
| JOB_ID            | Unique job identifier                        |
| JOB_TITLE         | Title of the job position                    |
| MIN_SALARY        | Minimum salary for the job                   |
| MAX_SALARY        | Maximum salary for the job                   |

## 4. Locations Table
This table contains details about the locations of various departments.

| Column Name       | Description                                  |
|-------------------|----------------------------------------------|
| LOCATION_ID       | Unique identifier for the location           |
| STREET_ADDRESS    | Street address of the location               |
| POSTAL_CODE       | Postal code for the location                 |
| CITY              | City where the location is situated          |
| STATE_PROVINCE    | State or province of the location            |
| COUNTRY_ID        | Country code for the location (e.g., 'US')   |

## 5. Countries Table
This table stores information about countries where the company operates.

| Column Name       | Description                                  |
|-------------------|----------------------------------------------|
| COUNTRY_ID        | Unique country identifier                    |
| COUNTRY_NAME      | Name of the country                          |
| REGION_ID         | ID of the region the country belongs to      |

## 6. Regions Table
This table stores information about the regions where the countries are located.

| Column Name       | Description                                  |
|-------------------|----------------------------------------------|
| REGION_ID         | Unique identifier for the region             |
| REGION_NAME       | Name of the region (e.g., 'Europe', 'Asia')  |

## 7. Job History Table
This table stores the job history for employees, showing the history of job changes within the organization.

| Column Name       | Description                                  |
|-------------------|----------------------------------------------|
| EMPLOYEE_ID       | Employee's ID                                |
| START_DATE        | Date when the employee started the job       |
| END_DATE          | Date when the employee ended the job         |
| JOB_ID            | Job identifier for the employee's previous job|
| DEPARTMENT_ID     | Department ID where the employee worked     |
