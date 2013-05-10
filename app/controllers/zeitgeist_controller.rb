class ZeitgeistController < ApplicationController
  def show
    @cloud_for_today = tag_counts(dreams_for_today)
    @cloud_for_all_time = tag_counts(Dream.unscoped)
  end

  protected

  def dreams_for_today
    Dream.created_since(24.hours.ago).created_before(Time.zone.now)
  end

  def tag_counts(dream_scope)
    dream_scope.joins(taggings: [:tag]).group(:name).reorder('count(*) DESC').limit(10).count
  end
end
