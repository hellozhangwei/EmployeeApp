class EmployeesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @employees = EmployeeService.new.search(params[:name])
  end

  def show
      # SELECT * FROM `employee_versions`
        # WHERE ((`employee_versions`.`master_id` = 4)
        # AND (`created_at` <= '2022-01-04 09:20:14.843269')
        # AND ((`expired_at` IS NULL) OR (`expired_at` > '2022-01-04 09:20:14.843500'))
        # AND (`valid_from` <= '2022-01-04 09:20:14.843600')
        # AND (`valid_to` > '2022-01-04 09:20:14.843668')) 
      # LIMIT 1
    # @employee = Employee.first(id: params[:id])

    @employee = Employee.find(id: params[:id])

    date = params[:date] ? params[:date] : Date.today

    @employee_version = EmployeeVersion.where(Sequel.lit('master_id = ? AND (valid_from is null OR valid_from<=?) AND (valid_to is null OR valid_to >=?)', @employee.id, date, date))

  end

  def edit
    @employee = Employee.find(id: params[:id])
  end

  def update

    @employee = Employee.find(id: params[:id])

    if params[:date].empty?
      result = @employee.update_attributes employee_params
    else
      result = @employee.update_attributes employee_params.merge(valid_from: params[:date])
      @employee.contracts.each do |contract|
        contract.update_attributes(valid_from: params[:date])
      end
    end

    if result # if you change nothing, it will retruen false and refresh edit page.
      @employee = Employee.find(id: params[:id])
      render :show
    else
      render :edit
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :address)
  end
end
