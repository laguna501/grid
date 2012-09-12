class Notifier < ActionMailer::Base
  default_url_options[:host] = Rails.configuration.notifier_default_host
  default_url_options[:port] = Rails.configuration.notifier_default_port
  default from: Rails.configuration.notifier_from_field

  def extend_facebook_access_token(user)
    @user = user
    mail(
      to: user.email,
      subject: "Extend facebook access token"
    )
  end

  def extend_instagram_access_token(user)
    @user = user
    mail(
      to: user.email,
      subject: "Extend instagram access token"
    )
  end

  def facebook_report_to_admin(user)
    @user = user
    mail(
      to: Rails.configuration.notifier_to_admin,
      subject: "#{@user.email}'s access token was expired"
    )
  end
end
