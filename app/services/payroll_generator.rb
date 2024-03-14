class PayrollGenerator
  attr_reader :payroll_days

  def initialize(payroll_days)
    @payroll_days = payroll_days
  end

  def generate
    start_date, end_date = payroll_dates
    Payroll.create(starts_at: start_date, ends_at: end_date)
  end

  private

  def payroll_dates
    current_date = Date.today
    current_year = current_date.year
    current_month = current_date.month
    current_day = current_date.day
    previous_day = current_date.yesterday.day

    payroll_days = @payroll_days.sort
    last_payroll_day, last_payroll_month = last_payroll_day_month

    payroll_day = find_payroll_day(payroll_days, last_payroll_day, current_day)

    start_date = start_date(payroll_day, current_date, last_payroll_month)
    end_date = end_date(previous_day, current_date, current_day, current_year, current_month, payroll_day)

    [start_date, end_date]
  end

  def start_date(payroll_day, current_date, payroll_month)
    month = Payroll.exists? ? payroll_month : (current_date - 2.month).month
    Date.new(current_date.year, month, payroll_day)
  end

  def end_date(previous_day, current_date, current_day, current_year, current_month, payroll_day)
    return current_date.yesterday if current_day == payroll_day

    Date.new(current_year, current_month, previous_day)
  end

  def find_payroll_day(payroll_days, last_payroll_day, current_day)
    payroll_days.find do |day|
      last_payroll_day ? (last_payroll_day + 1) == day : current_day
    end
  end

  def last_payroll_day_month
    payroll = Payroll.last&.ends_at
    day = payroll&.day
    month = payroll&.month

    [day, month]
  end
end
