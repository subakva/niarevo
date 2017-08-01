# frozen_string_literal: true

class DateRange
  attr_reader :min_date, :max_date

  def initialize(min_date = nil, max_date = nil)
    @min_date = min_date || Time.utc('2009')
    @max_date = max_date || Time.zone.now
  end

  def apply_year(year)
    apply_range(year, :year, :beginning_of_year, :end_of_year)
  end

  def apply_month(month)
    apply_range(month, :month, :beginning_of_month, :end_of_month)
  end

  def apply_day(day)
    apply_range(day, :day, :beginning_of_day, :end_of_day)
  end

  def apply_range(value, field, field_min_method, field_max_method)
    return if value.blank?
    @min_date = @min_date.change(field => value.to_i).send(field_min_method)
    @max_date = @max_date.change(field => value.to_i).send(field_max_method)
  end
end
