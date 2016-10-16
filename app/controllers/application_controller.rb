class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    def authenticate_admin!
        redirect_to root_path unless admin_signed_in?
    end

    def after_sign_in_path_for(resource)
        if resource.class.name == 'User'
            session[:next_url] || root_path
        elsif resource.class.name == 'Admin'
            admins_index_path
        end
    end
end
