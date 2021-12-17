require "test_helper"

class EmployeeTest < ActiveSupport::TestCase

  test "create employee" do

    employee = Employee.new(first_name: "David", last_name: "John")

    assert employee.save

    savedEmployee = Employee.find(employee.id).first
    assert employee.first_name=="David"
    assert employee.last_name=="John"

  end

  test "search employee" do

    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save
    employee_list = EmployeeService.new.search 'david'

    assert employee_list.first.first_name== 'David'
   
  end
end
