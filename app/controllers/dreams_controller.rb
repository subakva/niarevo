class DreamsController < ApplicationController

  before_filter :require_user, :only => [:edit, :update, :destroy]
  before_filter :load_dream, :only => [:show]
  before_filter :load_dream_for_user, :only => [:edit, :update, :destroy]

  def index
    render_dream_index(Dream)
  end

  def for_user
    if params[:id] == 'anonymous'
      render_dream_index(Dream.user_id_null)
    else
      render_dream_index(Dream.user_username_eq(params[:id]))
    end
  end

  def for_tag
    render_dream_index(Dream.with_tag(params[:id]))
  end

  def for_content_tag
    render_dream_index(Dream.with_content_tag(params[:id]))
  end

  def for_context_tag
    render_dream_index(Dream.with_context_tag(params[:id]))
  end

  def for_date
    min_date = Time.utc('2009')
    max_date = Time.now
    if params[:year]
      min_date = min_date.change(:year => params[:year].to_i).beginning_of_year
      max_date = max_date.change(:year => params[:year].to_i).end_of_year
    end
    if params[:month]
      min_date = min_date.change(:month => params[:month].to_i).beginning_of_month
      max_date = max_date.change(:month => params[:month].to_i).end_of_month
    end
    if params[:day]
      min_date = min_date.change(:day => params[:day].to_i).beginning_of_day
      max_date = max_date.change(:day => params[:day].to_i).end_of_day
    end
    render_dream_index(Dream.created_before(max_date).created_after(min_date))
  end

  def new
    @dream = Dream.new
  end

  def create
    @dream = Dream.new(params[:dream])
    @dream.user = current_user
    requires_captcha = current_user.blank?
    captcha_is_valid = !requires_captcha || verify_recaptcha(:model => @dream)
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
  
  def render_dream_index(scope)
    @dreams = scope.paginate(:per_page => 10, :page => params[:page])
    respond_to do |format|
      format.html { render :action => :index }
      format.atom { render :action => :index }
    end
  end

  def load_dream_for_user
    @dream = current_user.dreams.find_by_id(params[:id])
    unless @dream
      flash[:notice] = 'You are not allowed to edit that dream'
      redirect_to account_url
    end
  end

  def load_dream
    @dream = Dream.find(params[:id])
  end
  
end
