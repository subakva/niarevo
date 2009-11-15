class DreamsController < ApplicationController

  before_filter :require_user, :only => [:edit, :update, :destroy]
  before_filter :load_dream, :only => [:show]
  before_filter :load_dream_for_user, :only => [:edit, :update, :destroy]

  def index
    render_dream_index(Dream)
  end

  def for_user
    render_dream_index(Dream.user_login_eq(params[:id]))
  end

  def for_tag
    render_dream_index(Dream.with_tag(params[:id]))
  end

  def new
    @dream = Dream.new
  end

  def create
    @dream = Dream.new(params[:dream])
    @dream.user = current_user
    if @dream.save
      flash[:notice] = "Your dream has been saved."
      redirect_to dream_url(@dream)
    else
      render :action => :new
    end
  end

  def show
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
