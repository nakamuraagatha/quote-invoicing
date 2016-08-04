class CustomersController < ApplicationController
  before_filter :verify_admin
  def index
    @customers = Quote.all.map{|q| q.user}.uniq
  end
end
