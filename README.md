# README

Implement in Ruby on Rails, for the following problem:  model employees and contracts in a bitemporal database.

Models and attributes
* An Employee has a first_name (String), a last_name (String), a birth date (Date), and an address (multi-line text).
* A Contract has a start_date (Date), an end_date (Date), and a legal entity. In real life a legal entity would be a separate model, but for this assignment, we will keep things simple and use a String.
* All the attributes of the Employee and Contract models are bitemporal.
Relationships
Employees can have multiple contracts in time, but their contract periods do not overlap.

Create a Ruby on Rails project. We will use the rails console to perform some experiments.
Write a migration for employees.
Write a migration for contracts.
Add all the required classes.
Add a class/method to query all employees with a current contract, given some search criteria based on employee and contract attributes. ***
Use test-driven development.

You find the bitemporal plugin at https://github.com/TalentBox/sequel_bitemporal. It is a public repo.

The most important part of the exercise is marked with ***.