class EmployeeService

  def search (name)

    if name.nil?
      return
    end

    Employee.where(Sequel.like(Sequel.function(:lower, :first_name), "%#{name.downcase}%") | Sequel.like(Sequel.function(:lower, :last_name), "%#{name.downcase}%"))
  end


  def createContract(employee_id, start_date, end_date, legal)
    Contract.new(employee_id: employee_id, start_date: start_date, end_date: end_date, legal: legal )
    #Contract.create(employee_id: employee_id, start_date: start_date, end_date: end_date, legal: legal )
  end
end
