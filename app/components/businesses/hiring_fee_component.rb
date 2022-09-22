module Businesses
  class HiringFeeComponent < ApplicationComponent
    private attr_reader :user, :conversation

    def initialize(user, conversation)
      @user = user
      @conversation = conversation
    end

    def render?
      user.permissions.pays_hiring_fee? && conversation.hiring_fee_eligible?
    end

    def developer
      conversation.developer.name
    end

    def recipient
      Rails.configuration.emails.support!
    end

    def subject
      t(".subject")
    end

    def body
      t(".body", developer:)
    end
  end
end
