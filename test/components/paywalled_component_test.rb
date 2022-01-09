require "test_helper"

class PaywalledComponentTest < ViewComponent::TestCase
  test "should restrict paywall content" do
    user = users(:with_business)
    developer = developers(:available)

    render_inline(PaywalledComponent.new(user:, paywalled: developer)) { "Test text" }
    assert_no_text "Test text"

    render_inline(PaywalledComponent.new(user: nil, paywalled: developer)) { "Test text" }
    assert_no_text "Test text"

    render_inline(PaywalledComponent.new(user: nil, paywalled: nil)) { "Test text" }
    assert_no_text "Test text"
  end

  test "should show paywall content to customers" do
    user = users(:with_business_conversation)
    developer = developers(:available)
    render_inline(PaywalledComponent.new(user:, paywalled: developer)) { "Test text" }

    assert_text "Test text"
  end

  test "should show paywall content to the owner" do
    user = users(:with_available_profile)
    developer = developers(:available)
    render_inline(PaywalledComponent.new(user:, paywalled: developer)) { "Test text" }

    assert_text "Test text"
  end

  test "should show small CTA if paywalled" do
    user = users(:with_business)
    developer = developers(:available)

    render_inline(PaywalledComponent.new(user:, paywalled: developer, size: :small)) { "Test text" }
    assert_text I18n.t("paywalled_component.title")
    assert_no_text I18n.t("paywalled_component.description")
  end

  test "should show large CTA if paywalled" do
    user = users(:with_business)
    developer = developers(:available)

    render_inline(PaywalledComponent.new(user:, paywalled: developer, size: :large)) { "Test text" }
    assert_text I18n.t("paywalled_component.title")
    assert_text I18n.t("paywalled_component.description")
  end
end
