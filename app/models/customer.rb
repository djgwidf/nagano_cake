class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name,        presence: true
  validates :first_name,       presence: true
  validates :last_name_kana,   presence: true, format: {with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :first_name_kana,  presence: true, format: {with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :postal_code,      presence: true, format: {with: /\A\d{7}\z/}
  validates :telephone_number, presence: true, format: {with: /\A\d{10}$|^\d{11}\z/, message: '10桁か11桁の電話番号を入力してください。'}
  validates :address,          presence: true
  validates :is_active,        presence: true
  has_many :cart_items,        dependent: :destroy
  has_many :addresses,         dependent: :destroy
  has_many :orders,            dependent: :destroy
end
