class DateRange
  attr_reader :min_date, :max_date

  def initialize(min_date = nil, max_date = nil)
    @min_date = min_date || Time.utc('2009')
    @max_date = max_date || Time.zone.now
  end

  def apply_year(year)
    return unless year.present?
    @min_date = @min_date.change(year: year.to_i).beginning_of_year
    @max_date = @max_date.change(year: year.to_i).end_of_year
  end

  def apply_month(month)
    return unless month.present?
    @min_date = @min_date.change(month: month.to_i).beginning_of_month
    @max_date = @max_date.change(month: month.to_i).end_of_month
  end

  def apply_day(day)
    return unless day.present?
    @min_date = @min_date.change(day: day.to_i).beginning_of_day
    @max_date = @max_date.change(day: day.to_i).end_of_day
  end
end
