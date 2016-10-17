class UserMailer < ActionMailer::Base
    default from: 'contact@fanmade.kr'

    def welcome_email(user)
        @user = user
        attachments.inline['profile_img.png'] = File.read('app/assets/images/profile_img.png')
        mail(to: @user.email, subject: '팬메이드에 가입하신 것을 환영합니다')
    end
end