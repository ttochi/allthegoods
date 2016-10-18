class Group < ActiveRecord::Base
    has_many :members, dependent: :destroy
    accepts_nested_attributes_for :members, allow_destroy: true, reject_if: lambda {|attributes| attributes['name'].blank?}

    validates :name, presence: true

    has_attached_file :image, styles: { small: '64x64', med: '150x150' }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
