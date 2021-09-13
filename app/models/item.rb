class Item < ApplicationRecord
	validates :name,         presence: true
	validates :introduction, presence: true
	validates :price, 		   presence: true
	validates :is_active,    presence: true

	attachment :image_id
end
