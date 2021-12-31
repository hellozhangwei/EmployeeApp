10.times do
  employee = Employee.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, address: Faker::Address.full_address)

  Contract.create(employee_id:employee.id, start_date: '2020-01-01', end_date: '2020-01-31', legal: 'Shinetech')
end