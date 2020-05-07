require 'test_helper'

class AbilityTest < ActiveSupport::TestCase

  setup do
    @user = users(:chris)
  end

  test "profile abilities" do
    ability = Ability.new(@user)
    assert ability.can?(:edit, Profile.first)

    @user.profile.permissions = profiles(:technician).permissions

    ability = Ability.new(@user)
    assert ability.cannot?(:edit, Profile.first)
  end

end
