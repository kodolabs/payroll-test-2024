class PayrollsController < ApplicationController
  before_action :new_payroll, only: [:index]

  def index
    @payrolls = Payroll.ordered.all
  end

  def create
    payroll = Payroll.generate

    if payroll.persisted?
      flash[:notice] = 'Payroll has been successfully created.'
    else
      flash[:error] = "#{payroll.errors.messages.values.join}"
    end

    redirect_to action: :index
  end

  def destroy
    @payroll = Payroll.find params[:id]
    if @payroll.destroy
      redirect_to request.referrer
    end
  end

  private

  def new_payroll
    @new_payroll = Payroll.new
  end
end
