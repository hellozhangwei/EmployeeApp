10.times do
  employee = Employee.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, address: Faker::Address.full_address)
end