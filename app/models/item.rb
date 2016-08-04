class Item < ActiveRecord::Base
  validates_presence_of :name, :description, :image, :price

  validates_numericality_of :price
  mount_uploader :image, ItemUploader
end
