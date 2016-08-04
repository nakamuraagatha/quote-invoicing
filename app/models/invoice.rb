class Invoice < ActiveRecord::Base
  validates_presence_of :name, :description, :total, :user_id
  validates_numericality_of :total
end
