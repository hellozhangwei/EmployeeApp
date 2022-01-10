class EmployeesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @employees = EmployeeService.new.search(params[:name])
  end

  def show

    @employee = Employee.find(id: params[:id])

    date = params[:date] ? params[:date] : Date.today

    Sequel::Plugins::Bitemporal.at(date) do
      @employee.current_version(:reload => true)
    end

  end

  def edit
    @employee = Employee.find(id: params[:id])
  end

  def update

    @employee = Employee.find(id: params[:id])

    Sequel::Plugins::Bitemporal.at(params[:date]) do
      @employee.update_attributes(first_name: params[:first_name], address: params[:address])
    end

    Sequel::Plugins::Bitemporal.at(params[:date]) do
      @employee.current_version(:reload => true)
    end
     
    render :edit
    
  end

end
