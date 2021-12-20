require "test_helper"

class EmployeeTest < ActiveSupport::TestCase

  test "create employee" do

    employee = Employee.new(first_name: "David", last_name: "John")

    assert employee.save

    savedEmployee = Employee.find(employee.id).first
    assert employee.first_name=="David"
    assert employee.last_name=="John"

  end

  test "create contract" do

    start_date = Date.parse('2020-01-01')
    end_date = Date.parse('2020-12-31')
    legal = 'Shinetech'

    contract = Contract.new(start_date: start_date, end_date: end_date, legal: legal )
    assert contract.save

    contract = Contract.new(end_date: end_date, legal: legal )
    assert contract.valid?

    contract = Contract.new(start_date: start_date, legal: legal )
    assert contract.valid?


    contract = Contract.new(start_date: '2020-01-31', end_date: '2020-01-01', legal: legal )
    assert !contract.valid?

  end

  test "search employee" do

    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save
    employee_list = EmployeeService.new.search 'david'

    assert employee_list.first.first_name== 'David'
   
  end
end
