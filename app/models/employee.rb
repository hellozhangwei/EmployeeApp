class Employee < Sequel::Model
  def update_attributes (attr)
    employee = Employee.find(attr[:id]).first

    employee.update(attr.except(:id))
     
  end
  one_to_many :contracts
  plugin :bitemporal, version_class: EmployeeVersion
end
