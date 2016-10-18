class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :omniauthable, omniauth_providers: [:twitter]

    validates :nickname, presence: true, uniqueness: true, length: {maximum: 15}
    before_save :set_default_profile_image

    def self.find_for_twitter_oauth(auth)
        user = where(provider: auth.provider, uid: auth.uid).first
        user
    end

    def set_default_profile_image
        self.profile_image_url = Rails.configuration.default_profile_image_url if self.profile_image_url.blank?
    end
end
