class ZeitgeistController < ApplicationController
  def show
    todays_dreams = Dream.created_before(Time.now.utc.end_of_day).created_after(Time.now.utc.beginning_of_day)
    @cloud_for_today = Tag.cloud_for(todays_dreams)
    @cloud_for_all_time = Tag.cloud_for(Dream)
  end
end
