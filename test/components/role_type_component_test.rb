require "test_helper"

class RoleTypeComponentTest < ViewComponent::TestCase
  test "doesn't render with no role types selected" do
    role_type = role_types(:none)
    render_inline RoleTypeComponent.new(role_type)
    refute_component_rendered
  end

  test "renders each selected role type" do
    role_type = role_types(:some)

    render_inline RoleTypeComponent.new(role_type)

    assert_text RoleType.human_attribute_name("part_time_contract")
    assert_text RoleType.human_attribute_name("full_time_contract")
  end
end
