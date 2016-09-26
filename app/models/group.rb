class Group < ActiveRecord::Base
    has_many :members, dependent: :destroy
    accepts_nested_attributes_for :members, allow_destroy: true, reject_if: lambda {|attributes| attributes['name'].blank?}

    validates :name, presence: true
    validates :img, presence: true
end
