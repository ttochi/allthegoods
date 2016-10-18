class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def twitter
        @user = User.find_for_twitter_oauth(request.env['omniauth.auth'])

        if @user.nil?
            session[:sns_provider] = request.env['omniauth.auth'].provider
            session[:sns_uid] = request.env['omniauth.auth'].uid
            session[:profile_image_url] = request.env['omniauth.auth'].info.image
            session[:location] = request.env['omniauth.auth'].info.location
            session[:lang] = request.env['omniauth.auth'].extra.raw_info.lang

            redirect_to new_sns_registrations_path
        else
            sign_in_and_redirect @user, event: :authentication
            set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
        end
    end
end