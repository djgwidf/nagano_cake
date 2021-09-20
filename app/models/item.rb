class Item < ApplicationRecord
	validates :name,         presence: true
	validates :introduction, presence: true
	validates :price, 		   presence: true
	validates :is_active,    presence: true

	attachment :image_id
	# ！！with optionでまとめる！！
	has_many :cart_items, dependent: :destroy
	belongs_to :genre
	attachment :image_id
	enum is_active: [:販売可, :販売不可]
end
