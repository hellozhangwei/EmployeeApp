require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  test "update employee" do
    employee = Employee.new(first_name: "Wei2", last_name: "Zhang2")
    employee.save()
    employee.update_attributes(id:1, first_name: "Wei2 update222")
    assert employee.save, "Saved the employee with firstName and lastName"
  end
end
