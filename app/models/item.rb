class Item < ActiveRecord::Base
    has_many :members, through: :corresponds
    has_many :corresponds, dependent: :destroy
end
