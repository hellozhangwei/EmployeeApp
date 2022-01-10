10.times do
  address = Faker::Address.full_address
  # valid_from = Date.today - 1
  # employee = Employee.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, address: address)
  # EmployeeVersion.create(master_id: employee.id, address: address, valid_from: valid_from)
  employee = Employee.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  employee.update_attributes(address: address)
  Contract.create(employee_id:employee.id, start_date: '2020-01-01', end_date: '2020-01-31', legal: 'Shinetech')
end