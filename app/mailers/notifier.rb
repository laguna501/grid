class Notifier < ActionMailer::Base
  default_url_options[:host] = Rails.configuration.notifier_default_host
  default from: Rails.configuration.notifier_from_field

  def extend_facebook_access_token(account)
    @account = account
    mail(
      to: account.user.email,
      cc: Rails.configuration.notifier_to_admin,
      subject: "Request for facebook access token"
    )
  end

  def extend_instagram_access_token(account)
    @account = account
    mail(
      to: account.user.email,
      cc: Rails.configuration.notifier_to_admin,
      subject: "Request for instagram access token"
    )
  end
end
