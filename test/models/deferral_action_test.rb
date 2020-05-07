require 'test_helper'

class DeferralActionTest < ActiveSupport::TestCase

  setup do
    Current.user = users(:chris)
    @deferral = corrective_actions(:ca_other_in_wp_deferral)
  end

  test "job_started_at must be on or after activity boarding time" do
    @deferral.job_started_at = nil
    assert_not @deferral.valid?
    refute_empty @deferral.errors[:job_started_at]

    @deferral.job_started_at = @deferral.activity.boarded_at - 1.minute
    assert_not @deferral.valid?
    refute_empty @deferral.errors[:job_started_at]

    @deferral.job_started_at = @deferral.activity.boarded_at
    assert @deferral.valid?

    @deferral.job_started_at = @deferral.activity.boarded_at + 1.day
    assert @deferral.valid?
  end

  test "skip product params if defer_reason is other than no_parts" do
    @deferral.defer_reason = defer_reasons(:awaiting_customer_response)
    @deferral.product = products(:single_usb)
    @deferral.save
    assert_nil @deferral.product
  end

  test "product is required if defer_reason is no_parts" do
    @deferral.defer_reason = defer_reasons(:no_parts)
    assert_not @deferral.valid?
    refute_empty @deferral.errors[:product]
  end

  test "product must be one from aircraft bill_of_materials" do
    product_in_bom = products(:single_usb)
    product_outside_bom = Product.create(part_number: 'test', name: 'test_name', price: '10', product_category: product_categories(:display))

    @deferral.defer_reason = defer_reasons(:no_parts)
    @deferral.product = product_outside_bom
    assert_not @deferral.valid?
    refute_empty @deferral.errors[:product]

    @deferral.product = product_in_bom
    assert @deferral.valid?
  end

  test "activity and fault aircraft must be same" do
    other_aircraft = aircrafts(:gstba)

    assert @deferral.activity.aircraft == @deferral.fault.aircraft

    @deferral.activity.aircraft = other_aircraft
    assert_not @deferral.valid?
    refute_empty @deferral.errors[:base]
  end

  test "cannot edit deferral if originating activity is in complete or error state" do
    @deferral.activity.complete!
    @deferral.logbook_text = 'some text'
    assert @deferral.invalid?
    refute_empty @deferral.errors[:base]
  end

  test "logged-in user must have access to station and aircraft on edit" do
    Current.user = users(:maaz)
    @deferral.logbook_text = 'some text'

    assert @deferral.invalid?
    refute_empty @deferral.errors[:base]
  end

end
