# frozen_string_literal: true

class ZeitgeistController < ApplicationController
  def show
    @cloud_for_today = tag_counts(scope: dreams_for_today)
    @cloud_for_all_time = tag_counts(scope: Dream.all)
  end

  protected

  def dreams_for_today
    Dream.created_since(24.hours.ago).created_before(Time.zone.now)
  end

  def tag_counts(scope: Dream.unscoped, limit: 10)
    scope = scope.select('unnest(dream_tags || dreamer_tags) as tag, count(*) as tag_count')
    scope = scope.group('tag').reorder('tag_count DESC, tag DESC').limit(limit)
    scope.map { |d| [d.tag, d.tag_count] }.shuffle
  end
end
