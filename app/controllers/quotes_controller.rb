class QuotesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :can_access_quote, :only => [:edit, :update]
  before_filter :can_destroy_quote, :only => :destroy

  before_filter :set_quote, :only => [:edit, :update, :destroy]

  def index
    @quotes = current_user.quotes
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(permitted_quote_params.merge(user_id: current_user.id))
    if @quote.save
      flash[:success] = t("quotes.create.success")
      render 'quotes/index'
    else
      flash[:error] = @quote.errors.full_messages.join('\n').html_safe
      render 'quotes/new'
    end
  end

  def edit
  end

  def update
    if @quote.update(permitted_quote_params.except(:user_id))
      flash[:success] = t("quotes.update.success")
    else
      flash[:error] = @quote.errors.full_messages.join('\n').html_safe
    end
    render 'quotes/edit'
  end

  def destroy
    if @quote.destroy
      flash[:success] = t("quotes.destroy.success")
    else
      flash[:error] = t("quotes.destroy.error")
    end
  end

  private

  def can_access_quote
    unless current_user_is_admin? or current_user.quotes.exists?(id: params[:id])
      respond_to do |format|
        format.js { render :file => 'quotes/errors/access' }
      end
    end
  end

  def can_destroy_quote
    unless current_user_is_admin?
      respond_to do |format|
        format.js { render :file => 'quotes/errors/access' }
      end
    end
  end

  def set_quote
    @quote = current_user_is_admin? ? Quote.find(params[:id]) : current_user.quotes.find(id: params[:id])
  end

  def permitted_quote_params
    params.require(:quote).permit(:message, :user_id, :name)
  end
end
