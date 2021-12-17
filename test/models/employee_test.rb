require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  test "create employee" do
    # DB[:employee].delete
    # DB = Sequel.sqlite()
    
    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save()

    puts "================employee.id========#{employee.id}======="

    savedEmployee = Employee.find(employee.id).first
    puts "================savedEmployee========#{savedEmployee.id}======="
    assert employee.first_name=="David"
    assert employee.last_name=="John"

    # puts "================result========#{DB[:Employee].count}======="
  end

  test "search employee" do

    # employee = Employee.new(first_name: "Wei2", last_name: "Zhang2")
    # employee.save()
    # employee.update_attributes(id:1, first_name: "Wei2 update222")

    # result = employee.search("zhang")
    # puts "================result========#{result.count}======="
    # result.each do |em| 
       # puts "================em========#{em.first_name}======="
    # end 
    # assert employee.save, "Saved the employee with firstName and lastName"
 
  end
end
