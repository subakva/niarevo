# frozen_string_literal: true

require 'date_range'

class DreamsController < ApplicationController # rubocop:disable Metrics/ClassLength
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :load_dream, only: [:show]
  before_action :load_dream_for_edit, only: [:edit, :update, :destroy]

  def index
    @header_text = 'DreamTagger'
    render_dream_index(Dream.all)
  end

  def for_user
    if params[:id] == 'anonymous'
      @header_text = 'Anonymous Dreams'
      render_dream_index(Dream.where(user_id: nil))
    else
      @header_text = "#{params[:id].capitalize} Dreams"
      render_dream_index(Dream.joins(:user).where(users: { username: params[:id] }))
    end
  end

  def for_tag
    @header_text = "Tagged '#{params[:id]}'"
    render_dream_index(Dream.with_tag(params[:id]))
  end

  def for_dream_tag
    @header_text = "With dream tagged '#{params[:id]}'"
    render_dream_index(Dream.with_dream_tag(params[:id]))
  end

  def for_dreamer_tag
    @header_text = "With dreamer tagged '#{params[:id]}'"
    render_dream_index(Dream.with_dreamer_tag(params[:id]))
  end

  def untagged
    @header_text = "Untagged"
    scope = Dream.where('dreams.dreamer_tag_count = 0 OR dreams.dream_tag_count = 0')
    render_dream_index(scope)
  end

  def untagged_dreamer
    @header_text = "Without dreamer tags"
    render_dream_index(Dream.where(dreamer_tag_count: 0))
  end

  def untagged_dream
    @header_text = "Without dream tags"
    render_dream_index(Dream.where(dream_tag_count: 0))
  end

  # rubocop:disable Metrics/AbcSize
  def for_date
    range = DateRange.new
    range.apply_year(params[:year])
    range.apply_month(params[:month])
    range.apply_day(params[:day])

    @header_text = title_for_dates(range)
    scope = Dream.created_before(range.max_date)
    scope = scope.created_since(range.min_date)
    render_dream_index(scope)
  end
  # rubocop:enable Metrics/AbcSize

  def new
    @dream = Dream.new
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def create
    @dream = Dream.new(dream_params)
    @dream.user = current_user

    # call @dream.valid? first, so it does not overwrite the captcha error
    dream_valid = @dream.valid?
    captcha_is_valid = validate_captcha(@dream)
    if dream_valid && captcha_is_valid
      @dream.save!
      redirect_to dream_url(@dream), flash: { notice: "Your dream has been saved." }
    else
      flash.now[:warning] = @dream.errors[:captcha].join(', ') if @dream.errors[:captcha].present?
      render :new
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def show; end

  def preview
    @dream = Dream.new(dream_params)
    @dream.user = current_user
    render partial: 'dream', layout: false, object: @dream
  end

  def edit; end

  def update
    if @dream.update(dream_params)
      flash[:notice] = "Your dream has been saved."
      redirect_to dream_url(@dream)
    else
      render :edit
    end
  end

  protected

  def validate_captcha(model)
    return true if current_user.present?
    verify_recaptcha(model: model, attribute: :captcha, env: Rails.env.to_s)
  end

  def dream_params
    params.require(:dream).permit(:description, :joined_dream_tags, :joined_dreamer_tags, :private)
  end

  def title_for_dates(range)
    start_string = range.min_date.strftime('%d-%b-%Y')
    end_string = range.max_date.strftime('%d-%b-%Y')
    if start_string == end_string
      "Dreams On #{start_string}"
    else
      "Dreams From #{start_string} To #{end_string}"
    end
  end

  def render_dream_index(scope)
    @dreams = build_dream_scope(scope)
    @link_alternate = "#{request.path}?format=atom"
    respond_to do |format|
      format.html { render :index }
      format.atom { render :index }
    end
  end

  def build_dream_scope(scope)
    scope = Dream.visible_to(current_user).merge(scope)
    per_page = [10, (params[:show] || 5).to_i].min
    scope.page(params[:page]).per(per_page)
  end

  def load_dream_for_edit
    @dream = current_user ? current_user.dreams.where(id: params[:id]).first : nil
    return @dream if @dream

    flash[:notice] = 'You are not allowed to edit that dream.'
    redirect_to root_url
  end

  def load_dream
    @dream = Dream.visible_to(current_user).find(params[:id])
  end

  def handle_not_found
    flash[:notice] = "Sorry, that page doesn't exist!"
    redirect_to root_path
  end
end
