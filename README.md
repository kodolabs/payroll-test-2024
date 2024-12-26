# SETUP

- clone repository
- run ```bundle install``` and ```rake db:setup```
- start rails server

# The Task

Payroll is an entity that represents a header of a regular payroll document (salary).
It contains information about the period of the payroll - start and end dates.
Salary is paid two times a month for periods that start on 5-th and 20-th day of the month.

Example:

  - first payroll: 7 Jan - 19 Jan
  - second: 20 Jan - 4 Feb
  - third: 5 feb - 19 feb
  - and so on...

# Payroll generation rules

- If no payrolls exists yet, it should generate a payroll starting exactly 2 months ago
- Payrolls should not be generated for the future.
- Each new payroll should have consequent dates without gaps.

# What you have to do

1. On manual action it should generate a new payroll according to a schedule. 
   NOTE: Take into account that payroll schedule can be changed over time (to other days of month, frequency, etc.)
2. Advanced: trigger payroll generation automatically according to a schedule. 
