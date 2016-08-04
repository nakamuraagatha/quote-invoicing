class CustomersController < ApplicationController
  def index
    @customers = Quote.all.map{|q| q.user}.uniq
  end
end
