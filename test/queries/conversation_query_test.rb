require "test_helper"

class ConversationQueryTest < ActiveSupport::TestCase
  include BusinessesHelper
  include DevelopersHelper

  test "all conversations if entity isn't provided" do
    conversation = create_conversation
    query = ConversationQuery.new(nil)
    assert_includes query.records, conversation
  end

  test "conversations involving the entity, if provided" do
    developer = create_developer
    developer_conversation = create_conversation(developer:)
    other_conversation = create_conversation

    query = ConversationQuery.new(developer)

    assert_includes query.records, developer_conversation
    refute_includes query.records, other_conversation
  end

  test "conversations where the developer replied" do
    developer = create_developer
    business = create_business

    replied_to_conversation = create_conversation(developer:)
    replied_to_conversation.messages.create!(sender: developer, body: "Hi, business!")
    left_read_conversation = create_conversation(business:)
    left_read_conversation.messages.create!(sender: business, body: "Hi, developer!")

    query = ConversationQuery.new(nil)

    assert query.replied_to?(replied_to_conversation)
    refute query.replied_to?(left_read_conversation)
  end

  test "conversations where a message contains an email address" do
    developer = create_developer
    business = create_business

    with_developer_email = create_conversation(developer:)
    with_developer_email.messages.create!(sender: developer, body: "dev@example.com")
    with_business_email = create_conversation(business:)
    with_business_email.messages.create!(sender: business, body: "biz@example.com")
    other = create_conversation
    other.messages.create!(sender: developer, body: "Hi!")

    query = ConversationQuery.new(nil)

    assert query.potential_email?(with_developer_email)
    refute query.potential_email?(with_business_email)
    refute query.potential_email?(other)
  end

  def create_conversation(developer: nil, business: nil)
    developer ||= create_developer
    business ||= create_business
    Conversation.create(developer:, business:)
  end
end
