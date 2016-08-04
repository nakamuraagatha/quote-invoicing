class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :verify_admin

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(permitted_item_params)
    if @item.save
      flash[:success] = t('items.create.success')
      @items = Item.all
      render 'items/index'
    else
      flash[:error] = @item.errors.full_messages.join('\n').html_safe
      render 'items/new'
    end

  end

  def edit
  end

  def update
    if @item.update(permitted_item_params)
      flash[:success] = t("items.update.success")
    else
      flash[:error] = @item.errors.full_messages.join('\n').html_safe
    end
    render 'items/edit'
  end

  def destroy
    if @item.destroy
      flash[:success] = t("items.destroy.success")
    else
      flash[:error] = t("items.destroy.error")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permitted_item_params
      params.require(:item).permit(:name, :description, :image, :price)
    end
end
