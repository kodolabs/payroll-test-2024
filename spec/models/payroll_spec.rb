require 'rails_helper'

RSpec.describe Payroll, type: :model do

  describe 'generate' do
    before do
      stub_const('PAYROLL::PAYROLL_DAYS', [5, 20])
    end

    context 'No payrolls exists yet' do
      scenario 'Create new payroll with starts_at attribute equal 2 months ago' do
        allow(Date).to receive(:today).and_return(Date.new(2024, 3, 5))

        expect {
          Payroll.generate
        }.to change(Payroll, :count).by(1)

        created_payroll = Payroll.last
        expect(created_payroll.starts_at).to eq(Date.new(2024, 1, 5))
        expect(created_payroll.ends_at).to eq(Date.new(2024, 3, 4))
      end
    end

    context 'Payroll exists' do
      scenario 'Create new payroll for the next period' do
        allow(Date).to receive(:today).and_return(Date.new(2024, 3, 5))

        expect {
          Payroll.generate
        }.to change(Payroll, :count).by(1)

        #----------------------------------------------------------------------------
        allow(Date).to receive(:today).and_return(Date.new(2024, 3, 20))

        expect {
          Payroll.generate
        }.to change(Payroll, :count).by(1)

        created_payroll = Payroll.last
        expect(created_payroll.starts_at).to eq(Date.new(2024, 3, 5))
        expect(created_payroll.ends_at).to eq(Date.new(2024, 3, 19))

        #----------------------------------------------------------------------------
        allow(Date).to receive(:today).and_return(Date.new(2024, 4, 5))

        expect {
          Payroll.generate
        }.to change(Payroll, :count).by(1)

        created_payroll = Payroll.last
        expect(created_payroll.starts_at).to eq(Date.new(2024, 3, 20))
        expect(created_payroll.ends_at).to eq(Date.new(2024, 4, 4))

        #----------------------------------------------------------------------------
        allow(Date).to receive(:today).and_return(Date.new(2024, 4, 20))

        expect {
          Payroll.generate
        }.to change(Payroll, :count).by(1)

        created_payroll = Payroll.last

        expect(created_payroll.starts_at).to eq(Date.new(2024, 4, 5))
        expect(created_payroll.ends_at).to eq(Date.new(2024, 4, 19))
      end
    end
  end
end

