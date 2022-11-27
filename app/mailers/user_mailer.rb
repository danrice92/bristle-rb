class UserMailer < ApplicationMailer
  def verify_email
    @user = params[:user]
    @code  = @user.verification_code
    mail(to: @user.email, subject: "Welcome to Bristle!")
  end

  def login
    @user = params[:user]
    @code  = @user.verification_code
    mail(to: @user.email, subject: "Bristle login attempt")
  end
end
