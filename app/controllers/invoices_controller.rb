class InvoicesController < ApplicationController
  before_action :verify_admin
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]


  def index
    @invoices = Invoice.all
  end

  def show
  end

  def new
    @invoice = Invoice.new
  end

  def edit
  end


  def create
    @invoice = Invoice.new(permitted_invoice_params)

    if @invoice.save
      flash[:success] = t("invoices.create.success")
      @invoices = Invoice.all
      render 'invoices/index'
    else
      flash[:error] = @invoice.errors.full_messages.join('\n').html_safe
      render 'invoices/new'
    end
  end

  def update
    if @invoice.update(permitted_invoice_params)
      flash[:success] = t("invoices.update.success")
    else
      flash[:error] = @invoice.errors.full_messages.join('\n').html_safe
    end

    render 'invoices/edit'

  end

  def destroy
    if @invoice.destroy
      flash[:success] = t("invoices.destroy.success")
    else
      flash[:error] = t("invoices.destroy.error")
      render 'invoices/index'
    end
  end

  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def permitted_invoice_params
      params.require(:invoice).permit(:name, :description, :user_id, :quote_id, :total)
    end
end
