class EmployeesController < ApplicationController
  def index
    @employees = EmployeeService.new.search(params[:name])
  end

  def show
    @employee = Employee.first(id: params[:id])
  end
end
