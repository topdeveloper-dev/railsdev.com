module IosNotification
  def ios_format(apn)
    apn.alert = {title:, body: ios_subject}
    apn.custom_payload = {url:}
  end

  def ios_cert_path
    StringIO.new(Rails.application.credentials.ios.apns_token_cert)
  end

  # Use APNS's sandbox server to send notifications to apps run via Xcode.
  def development?
    Rails.env.development?
  end

  def ios_device_tokens(recipient)
    recipient.notification_tokens.where(platform: "iOS").pluck(:token)
  end

  def cleanup_device_token(token:, platform:)
    NotificationToken.find_by(token: token.token, platform:)&.destroy
  end
end
