require 'test_helper'

class NetaxeptNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @netaxept = Netaxept::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @netaxept.complete?
    assert_equal "", @netaxept.status
    assert_equal "", @netaxept.transaction_id
    assert_equal "", @netaxept.item_id
    assert_equal "", @netaxept.gross
    assert_equal "", @netaxept.currency
    assert_equal "", @netaxept.received_at
    assert @netaxept.test?
  end

  def test_compositions
    assert_equal Money.new(3166, 'USD'), @netaxept.amount
  end

  # Replace with real successful acknowledgement code
  def test_acknowledgement

  end

  def test_send_acknowledgement
  end

  def test_respond_to_acknowledge
    assert @netaxept.respond_to?(:acknowledge)
  end

  private
  def http_raw_data
    ""
  end
end
