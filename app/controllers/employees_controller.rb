class EmployeesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @employees = EmployeeService.new.search(params[:name])
  end

  def show
    # @employee = Employee.first(id: params[:id])
    @employee = Employee.find(id: params[:id])
  end

  def edit
    @employee = Employee.find(id: params[:id])
  end

  def update

    @employee = Employee.find(id: params[:id])

    if(params[:date].empty?)
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
