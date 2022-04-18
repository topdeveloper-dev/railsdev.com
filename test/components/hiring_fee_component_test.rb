require "test_helper"

class HiringFeeComponentTest < ViewComponent::TestCase
  setup do
    @conversation = conversations(:one)
    @user = @conversation.business.user
  end

  test "renders if full-time subscription and is eligible for the fee" do
    @conversation.update!(created_at: 2.weeks.ago - 1.day)

    render_inline HiringFeeComponent.new(@user, @conversation)
    assert_text "Have you hired"
  end

  test "doesn't render if not on a full-time subscription" do
    @conversation.update!(created_at: 2.weeks.ago - 1.day)
    pay_subscriptions(:full_time).update!(processor_plan: BusinessSubscription::PartTime.new.plan)

    render_inline HiringFeeComponent.new(@user, @conversation)
    assert_no_text "Have you hired"
  end

  test "doesn't render if the conversation is not eligible for the fee" do
    render_inline HiringFeeComponent.new(@user, @conversation)
    assert_no_text "Have you hired"
  end
end
