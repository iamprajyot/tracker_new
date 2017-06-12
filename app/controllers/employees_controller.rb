class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:success] = 'Employee was successfully created.'
    else
      flash[:error] = @employee.errors.messages.values.join('<br/>')
    end
    redirect_to employees_path
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    if @employee.update(employee_params)
      flash[:success] = 'Employee was successfully updated.'
    else
      flash[:error] = @employee.errors.messages.values.join('<br/>')
    end
    redirect_to employees_path
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.update_attributes(is_deleted: !@employee.is_deleted)
    action = @employee.is_deleted? ? 'soft deleted' : 'activated'
    flash[:success] = "Employee was successfully #{action}"
    redirect_to employees_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:username, :is_deleted)
    end
end
