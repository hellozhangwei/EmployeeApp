class EmployeesController < ApplicationController
  def index
    @employees = EmployeeService.new.search(params[:name])
  end
end
