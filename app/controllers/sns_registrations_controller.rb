class SnsRegistrationsController < ApplicationController
    def new
        if session[:sns_provider].blank?
            redirect_to root_path
        else
            @user = User.new
        end
    end

    def create
        params[:user][:provider] = session[:sns_provider]
        params[:user][:uid] = session[:sns_uid]
        params[:user][:profile_image_url] = session[:profile_image_url]
        params[:user][:location] = session[:location]
        params[:user][:lang] = session[:lang]
        params[:user][:password] = Devise.friendly_token(20)
        params[:user][:password_confirmation] = params[:user][:password]

        @user = User.new(sign_up_params)

        respond_to do |format|
            if @user.save
                session[:sns_provider] = ''
                session[:sns_uid] = ''
                session[:profile_image_url] = ''
                session[:location] = ''
                session[:lang] = ''

                format.html { sign_in_and_redirect @user, event: :authentication }
            else
                format.html { render action: 'new' }
            end
        end
    end

    private
    def sign_up_params
        params.require(:user).permit(User.attribute_names + [:password, :password_confirmation])
    end
end