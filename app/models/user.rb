class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :omniauthable, omniauth_providers: [:twitter]

    validates :nickname, presence: true, uniqueness: true, length: {maximum: 15}
    before_save :set_default_profile_image

    def self.find_for_twitter_oauth(auth)
        user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = "#{auth.uid}@twitter.com"
            user.password = Devise.friendly_token[0,20]
            user.nickname = auth.info.nickname
            user.profile_image_url = auth.info.image
            user.location = auth.info.location
            user.lang = auth.extra.raw_info.lang
        end

        user
    end

    def set_default_profile_image
        self.profile_image_url = Rails.configuration.default_profile_image_url if self.profile_image_url.blank?
    end
end
