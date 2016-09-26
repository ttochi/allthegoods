class Member < ActiveRecord::Base
    belongs_to :group
    has_many :items, through: :corresponds
    has_many :corresponds, dependent: :destroy
end
