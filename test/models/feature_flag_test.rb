require 'test_helper'

class FeatureFlagTest < ActiveSupport::TestCase
    setup do
        @feature_flag = feature_flags(:one)
        @feature_flag_f = feature_flags(:two)
        @blankfeatures = "NonameFeatures"
    end

    test "create valid new feature" do
        featured = FeatureFlag.new(name: 'new feature', enabled: true)
        assert featured.valid?
    end

    test "new user should have unique name" do
        featured = FeatureFlag.new(name: @feature_flag.name)
        assert featured.invalid?
    end

    test "enabled is true" do
        assert_equal FeatureFlag.get?(@feature_flag.name), true
    end

    test "enabled is false" do
        assert_equal FeatureFlag.get?(@feature_flag_f.name), false
    end

    test "name does not exist" do
        assert_equal FeatureFlag.get?(@blankfeatures), true
    end

end
