class Employee < Sequel::Model
  # attr_accessor :first_name
  one_to_many :contracts
  plugin :bitemporal, version_class: EmployeeVersion
end
