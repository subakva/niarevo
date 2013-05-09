require 'date_range'

class DreamsController < ApplicationController

  before_filter :require_user, :only => [:edit, :update, :destroy]
  before_filter :load_dream, :only => [:show]
  before_filter :load_dream_for_user, :only => [:edit, :update, :destroy]

  def index
    @header_text = 'DreamTagger'
    render_dream_index(Dream.scoped)
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

  def for_content_tag
    @header_text = "With dream tagged '#{params[:id]}'"
    render_dream_index(Dream.with_content_tag(params[:id]))
  end

  def for_context_tag
    @header_text = "With dreamer tagged '#{params[:id]}'"
    render_dream_index(Dream.with_context_tag(params[:id]))
  end

  def untagged
    @header_text = "Untagged"
    scope = Dream.where('dreams.context_tag_count = 0 OR dreams.content_tag_count = 0')
    render_dream_index(scope)
  end

  def untagged_context
    @header_text = "Without dreamer tags"
    render_dream_index(Dream.where(context_tag_count: 0))
  end

  def untagged_content
    @header_text = "Without dream tags"
    render_dream_index(Dream.where(content_tag_count: 0))
  end

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

  def new
    @dream = Dream.new
  end

  def create
    # TODO: strong_parameters
    # TODO: handle assigning tags properly
    @dream = Dream.new(params[:dream])
    @dream.user = current_user
    requires_captcha = current_user.blank?
    captcha_is_valid = !requires_captcha || verify_recaptcha(model: @dream)
    if captcha_is_valid && @dream.save
      flash[:notice] = "Your dream has been saved."
      redirect_to dream_url(@dream)
    else
      render :action => :new
    end
  end

  def show
  end

  def preview
    @dream = Dream.new(params[:dream])
    render :partial => 'dream', :layout => false, :object => @dream
  end

  def edit
  end

  def update
    if @dream.update_attributes(params[:dream])
      flash[:notice] = "Your dream has been saved."
      redirect_to dream_url(@dream)
    else
      render :action => :edit
    end
  end

  protected
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
    @dreams = scope.page(params[:page]).per(5)
    @link_alternate = "#{request.path}?format=atom"
    respond_to do |format|
      format.html { render :action => :index }
      format.atom { render :action => :index }
    end
  end

  def load_dream_for_user
    @dream = current_user.dreams.where(id: params[:id]).first
    unless @dream
      flash[:notice] = 'You are not allowed to edit that dream'
      redirect_to account_url
    end
  end

  def load_dream
    @dream = Dream.find(params[:id])
  end

end
