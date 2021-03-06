class EmployeeService

  def search (name)

    # todo pagination
    
    if name.nil? || name.strip.empty?
      puts "==========name is nil======"
      return Employee.all
    end

    Employee.where(Sequel.like(Sequel.function(:lower, :first_name), "%#{name.downcase}%") | Sequel.like(Sequel.function(:lower, :last_name), "%#{name.downcase}%"))
  end


  def searchCurrentContract(employee_id)
    
    now = DateTime.now
    Contract.where(Sequel.lit('employee_id = ? AND (start_date is null OR start_date<=?) AND (end_date is null OR end_date >=?)', employee_id, now, now))
  end
end
