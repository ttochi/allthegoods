class Item < ActiveRecord::Base
    has_many :members, through: :corresponds
    has_many :corresponds, dependent: :destroy

    validates :name, presence: true
    validates :seller_url, presence: true
end
