class Payroll < ApplicationRecord
  PAYROLL_DAYS = [5, 20].freeze

  validates :starts_at, presence: true, uniqueness: { scope: :ends_at, message: :taken }
  validates :ends_at, presence: true

  validate :check_day_for_payroll, on: :create
  validate :ends_at_greater_than_starts_at, on: :create

  scope :ordered, -> { order(starts_at: :desc) }

  def self.generate
    payroll_generator = PayrollGenerator.new(PAYROLL_DAYS)
    payroll_generator.generate
  end

  private

  def check_day_for_payroll
    return if PAYROLL_DAYS.include? Date.today.day

    errors.add(:created_at, "You can create payroll in #{PAYROLL_DAYS.join(', ')} days of month.")
  end

  def ends_at_greater_than_starts_at
    return if starts_at.nil? || ends_at.nil?

    errors.add(:ends_at, :taken) if starts_at >= ends_at
  end
end
