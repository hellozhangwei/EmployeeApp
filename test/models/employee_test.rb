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

    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save
    employee_id = employee.id

    contract = Contract.new(employee_id:employee_id, start_date: start_date, end_date: end_date, legal: legal)
    assert contract.save

    contract = Contract.new(employee_id:employee_id,start_date: start_date, end_date: end_date)
    assert !contract.valid?

    contract = Contract.new(employee_id:employee_id,end_date: end_date, legal: legal)
    # assert contract.valid?

    contract = Contract.new(employee_id:employee_id,start_date: start_date, legal: legal)
    # assert contract.valid?


    # end date > start date
    contract = Contract.new(employee_id:employee_id,start_date: '2020-01-31', end_date: '2020-01-01', legal: legal)
    assert !contract.valid?

    # overlap if there there is any reocords in db
    contract = Contract.new(employee_id:employee_id,legal: legal)
    assert !contract.valid?

    #start date is nil and end date is not nil, overlap if the 
    contract = Contract.new(employee_id:employee_id,end_date: end_date, legal: legal)
    assert !contract.valid?


  end

  test "create contract date overlap with start date and end date are nil in db" do

    legal = 'Shinetech'
    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save
    employee_id = employee.id

    contract = Contract.new(employee_id:employee_id, legal: legal)
    contract.save

    contract = Contract.new(employee_id:employee_id, legal: legal)
    assert !contract.valid?

    contract = Contract.new(employee_id:employee_id, start_date: '2020-01-01', legal: legal)
    assert !contract.valid?

    contract = Contract.new(employee_id:employee_id, start_date: '2020-01-01', end_date: '2020-01-02', legal: legal)
    assert !contract.valid?

    contract = Contract.new(employee_id:employee_id, end_date: '2020-01-01', legal: legal)
    assert !contract.valid?

  end

  test "create contract date overlap with start date is nil in db" do

    legal = 'Shinetech'
    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save
    employee_id = employee.id

    contract = Contract.new(employee_id:employee_id, end_date: '2020-01-01', legal: legal)
    contract.save

    contract = Contract.new(employee_id:employee_id, start_date:'2020-01-02', legal: legal)
    assert contract.valid?

    contract = Contract.new(employee_id:employee_id, start_date:'2019-12-31', legal: legal)
    assert !contract.valid?

    contract = Contract.new(employee_id:employee_id, end_date:'2019-12-31', legal: legal)
    assert !contract.valid?

    contract = Contract.new(employee_id:employee_id, end_date:'2020-01-02', legal: legal)
    assert !contract.valid?

    contract = Contract.new(employee_id:employee_id, legal: legal)
    assert !contract.valid?

  end

  test "create contract date overlap with end date is nil in db" do
    legal = 'Shinetech'
    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save
    employee_id = employee.id

    contract = Contract.new(employee_id:employee_id, start_date: '2020-01-01', legal: legal)
    contract.save

    contract = Contract.new(employee_id:employee_id, end_date:'2019-12-31', legal: legal)
    assert contract.valid?

    contract = Contract.new(employee_id:employee_id, end_date:'2020-01-02', legal: legal)
    assert !contract.valid?


    contract = Contract.new(employee_id:employee_id, start_date:'2019-12-31', legal: legal)
    assert !contract.valid?

    contract = Contract.new(employee_id:employee_id, start_date:'2020-01-02', legal: legal)
    assert !contract.valid?

    contract = Contract.new(employee_id:employee_id, legal: legal)
    assert !contract.valid?
  end


  test "create contract date overlap with start date and end date are not null in db" do
    legal = 'Shinetech'
    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save
    employee_id = employee.id

    contract = Contract.new(employee_id:employee_id, start_date: '2020-01-01', end_date:'2020-12-31', legal: legal)
    contract.save

    contract = Contract.new(employee_id:employee_id, end_date:'2019-12-31', legal: legal)
    assert contract.valid?

    contract = Contract.new(employee_id:employee_id, start_date:'2021-01-01', legal: legal)
    assert contract.valid?

    contract = Contract.new(employee_id:employee_id, end_date:'2020-01-02', legal: legal)
    assert !contract.valid?

    contract = Contract.new(employee_id:employee_id, start_date:'2020-01-02', legal: legal)
    assert !contract.valid?

    contract = Contract.new(employee_id:employee_id, legal: legal)
    assert !contract.valid?
  end


  test "search employee" do

    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save

    contract = Contract.new(employee_id:employee.id, start_date: '2020-01-01', end_date: '2020-01-31', legal: 'Shinetech')
    assert contract.save

    employee_list = EmployeeService.new.search 'david'

    assert employee_list.first.first_name== 'David'
    assert employee_list.first.contracts.first.legal == 'Shinetech'
   
  end

  test "search current contract" do

    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save

    contract = Contract.new(employee_id:employee.id, start_date: Date.parse('2020-01-01'), end_date: Date.parse('2020-01-31'), legal: 'Shinetech')
    contract.save

    now = DateTime.now
    contract = Contract.new(employee_id:employee.id, start_date: (now - 1), end_date: (now + 1), legal: 'Shinetech')
    contract.save

    now = DateTime.now
    contract = Contract.new(employee_id:employee.id, start_date: (now + 2), legal: 'Shinetech')
    contract.save

    contract_list = EmployeeService.new.searchCurrentContract employee.id
    assert contract_list.all.length == 1

  end

  test "search current contract if there is no end date" do

    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save

    contract = Contract.new(employee_id:employee.id, start_date: Date.parse('2020-01-01'), end_date: Date.parse('2020-01-31'), legal: 'Shinetech')
    contract.save

    now = DateTime.now
    contract = Contract.new(employee_id:employee.id, start_date: '2020-02-01', legal: 'Shinetech')
    contract.save

    contract_list = EmployeeService.new.searchCurrentContract employee.id
    assert contract_list.all.length == 1

  end

   test "search current contract if there is no start date" do

    employee = Employee.new(first_name: "David", last_name: "John")
    employee.save

    now = DateTime.now
    contract = Contract.new(employee_id:employee.id, start_date: now + 2, end_date: now + 3, legal: 'Shinetech')
    contract.save

    now = DateTime.now
    contract = Contract.new(employee_id:employee.id, end_date: now + 1, legal: 'Shinetech')
    contract.save

    contract_list = EmployeeService.new.searchCurrentContract employee.id
    assert contract_list.all.length == 1

  end

  test "defines current_versions_dataset" do
    initial_today = Date.today
    employee = Employee.new
    employee.update_attributes first_name: "Single Standard", valid_from: initial_today+1
    employee.update_attributes first_name: "King Size", valid_from: initial_today+2

    versions = employee.versions
    current_version = employee.current_version
    assert versions.size == 3
    # assert versions[2].first_name == "King Size"
  end

end
