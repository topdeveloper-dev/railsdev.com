require "test_helper"

class MessagePolicyTest < ActiveSupport::TestCase
  setup do
    @conversation = conversations(:one)
    @message = @conversation.messages.new
  end
  test "developers involved in the conversation can send messages" do
    developer = @conversation.developer
    assert MessagePolicy.new(developer.user, @message).create?
  end

  test "folks not involved in the conversation can't send messages" do
    user = users(:business)
    refute MessagePolicy.new(user, @message).create?

    user = users(:developer)
    refute MessagePolicy.new(user, @message).create?

    user = users(:empty)
    refute MessagePolicy.new(user, @message).create?
  end

  test "businesses without an active subscription can't send messages" do
    user = @conversation.business.user
    pay_subscriptions(:full_time).delete
    refute MessagePolicy.new(user, @message).create?
  end

  test "businesses on part-time plans can't message developers only seeking full-time roles" do
    user = @conversation.business.user
    update_subscription(BusinessSubscription::PartTime)
    assert MessagePolicy.new(user, @message).create?

    @conversation.developer.role_type.update!(
      full_time_employment: true,
      part_time_contract: false,
      full_time_contract: false
    )
    refute MessagePolicy.new(user, @message).create?
  end

  def update_subscription(plan_class)
    pay_subscriptions(:full_time).update!(processor_plan: plan_class.new.price_id)
  end
end
