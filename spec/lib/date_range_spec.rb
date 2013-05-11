require 'spec_helper'
require 'date_range'

describe DateRange do
  before { Timecop.freeze }
  after { Timecop.return }

  let(:min_date) { Time.utc('2009') }
  let(:max_date) { Time.zone.now }
  subject(:date_range) { DateRange.new(min_date, max_date) }

  context 'with no min or max date' do
    let(:min_date) { nil }
    let(:max_date) { nil }

    it 'sets a default min_date' do
      expect(date_range.min_date).to eql(Time.utc('2009'))
    end

    it 'sets a default max_date' do
      expect(date_range.max_date).to eql(Time.zone.now)
    end
  end

  context 'with a min and max date' do
    let(:min_date) { 12.days.ago }
    let(:max_date) { 24.days.ago }

    it 'returns the specified min_date' do
      expect(date_range.min_date).to eql(min_date)
    end

    it 'returns the specified max_date' do
      expect(date_range.max_date).to eql(max_date)
    end
  end

  describe '#apply_year' do
    let(:min_date) { Time.zone.parse('1979-02-07') }
    let(:max_date) { Time.zone.parse('2010-05-16') }

    let(:new_year) { '2007' }
    before { date_range.apply_year(new_year) }

    it 'sets the min_date to the beginning of the year' do
      expect(date_range.min_date).to be_within(1).of Time.zone.parse('2007-01-01 00:00:00')
    end

    it 'sets the max_date to the end of the year' do
      expect(date_range.max_date).to be_within(1).of Time.zone.parse('2007-12-31 23:59:59')
    end

    context 'with a blank year' do
      let(:new_year) { '' }

      it 'does not change the min_date' do
        expect(date_range.min_date).to eql(min_date)
      end

      it 'does not change the max_date' do
        expect(date_range.max_date).to eql(max_date)
      end
    end
  end

  describe '#apply_month' do
    let(:min_date) { Time.zone.parse('1979-02-07') }
    let(:max_date) { Time.zone.parse('2010-05-16') }
    let(:new_month) { '6' }
    before { date_range.apply_month(new_month) }

    it 'sets the min_date to the beginning of the month' do
      expect(date_range.min_date).to be_within(1).of Time.zone.parse('1979-06-01 00:00:00')
    end

    it 'sets the max_date to the end of the month' do
      expect(date_range.max_date).to be_within(1).of Time.zone.parse('2010-06-30 23:59:59')
    end

    context 'with a blank month' do
      let(:new_month) { '' }

      it 'does not change the min_date' do
        expect(date_range.min_date).to eql(min_date)
      end

      it 'does not change the max_date' do
        expect(date_range.max_date).to eql(max_date)
      end
    end
  end

  describe '#apply_day' do
    let(:min_date) { Time.zone.parse('1979-02-07') }
    let(:max_date) { Time.zone.parse('2010-05-16') }
    let(:new_day) { '19' }
    before { date_range.apply_day(new_day) }

    it 'sets the min_date to the beginning of the day' do
      expect(date_range.min_date).to be_within(1).of Time.zone.parse('1979-02-19 00:00:00')
    end

    it 'sets the max_date to the end of the day' do
      expect(date_range.max_date).to be_within(1).of Time.zone.parse('2010-05-19 23:59:59')
    end

    context 'with a blank day' do
      let(:new_day) { '' }

      it 'does not change the min_date' do
        expect(date_range.min_date).to eql(min_date)
      end

      it 'does not change the max_date' do
        expect(date_range.max_date).to eql(max_date)
      end
    end
  end
end
