class Notifier < ActionMailer::Base
  default_url_options[:host] = Rails.configuration.notifier_default_host
  default_url_options[:port] = Rails.configuration.notifier_default_port
  default from: Rails.configuration.notifier_from_field

  def extend_facebook_access_token(account)
    @account = account
    mail(
      to: account.user.email,
      subject: "Extend facebook access token"
    )
  end

  def extend_instagram_access_token(account)
    @account = account
    mail(
      to: account.user.email,
      subject: "Extend instagram access token"
    )
  end

  def facebook_report_to_admin(account)
    @account = account
    mail(
      to: Rails.configuration.notifier_to_admin,
      subject: "#{@account.user.email}'s access token was expired"
    )
  end
end
