class RegistrationsController < Devise::RegistrationsController
    def create
        super
        # TODO UserMailer.welcome_email(resource).deliver unless resource.invalid?
    end

    private
    def sign_up_params
        params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :current_password)
    end
end