class ZeitgeistController < ApplicationController
  def show
    # @cloud_for_today = Dream.where(
    #   [
    #     'created_at between ? and ?',
    #     Time.zone.now.beginning_of_day,
    #     Time.zone.now.end_of_day
    #   ]
    # )
    # @cloud_for_all_time = Dream.unscoped
  end
end
