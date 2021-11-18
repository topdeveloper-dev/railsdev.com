class SocialLinkComponent < ApplicationComponent
  attr_reader :network

  def initialize(handle, network)
    @handle = handle
    @network = network
  end

  def render?
    handle.present?
  end

  def handle
    sanitize(@handle)
  end

  def url
    case network
    when :github
      "https://github.com/#{handle}"
    when :twitter
      "https://twitter.com/#{handle}"
    when :linkedin
      "https://www.linkedin.com/in/#{handle}"
    end
  end

  def icon
    "icons/brands/#{network}"
  end
end
