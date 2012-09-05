require 'test_helper'
require 'debugger'
#require 'rest_client'

class NetaxeptModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations
  include ActionViewHelperTestHelper

  ::GATEWAY = ActiveMerchant::Billing::NetaxeptGateway.new(
     :login      => "test",
     :password   => "test"
  )

  def test_notification_method
    assert_instance_of Netaxept::Notification, Netaxept.notification('name=cody')
  end

  def test_test_mode
    ActiveMerchant::Billing::Base.integration_mode = :test
    assert_equal 'https://epayment-test.bbs.no/terminal/default.aspx', Netaxept.service_url
  end

  def test_production_mode
    ActiveMerchant::Billing::Base.integration_mode = :production
    assert_equal 'https://epayment-test.bbs.no/terminal/default.aspx', Netaxept.service_url
  end

  def test_invalid_mode
    ActiveMerchant::Billing::Base.integration_mode = :karamba
    assert_raise(StandardError){ Netaxept.service_url }
  end

  # TODO shouldn't be in unit test move directo to application
 # def test_collect_setup_string
 #   options = {:redirectUrl => "http://test.url.com", :transationId => "12d1d12d12d2", :amount => 1150, :orderNumber => 44}
 #   result = GATEWAY.setup_authorization(options)
 #   RestClient.post Netaxept.service_url, { "BBSePay_transaction" =>"IYIClFqCApA8TVNHKzYrU2lnRGF0I1ZFUis1KzMuMC4yI1NZUyszK1BPUyNDSUQrMjArNWJkYjBkYjQ2MDI5NDljNDhmYWUjVElNKzEwKzEyMjAwNDYyNDcjREFUKzIwNCtRZ3BOUWk0d01ESXVNVFk1UndZeU1EQTVNRFpJQTA1UFMwc0dOVGM0TWpBd1RpQTRZVGt5Tm1Oa05EZzNZbVV4WXpKaU56QTJZVFUzTUdSa1l6UmhZelJtWWxJRU1URTFNRlVPTWpBeE1qQTNNVGd4TkRVd05EZFhBalEwWHpVQk1WODlEUzVPUlZRZ1VDOUpiblp2YTJWZmdRQUJJRitCQVJOb2RIUndPaTh2ZEdWemRDNTFjbXd1WTI5dFg0RXdCalF6TlRRME1RPT0jUDdTKzM1MitNSUlCQWdZSktvWklodmNOQVFjQ29JSDBNSUh4QWdFQk1Rc3dDUVlGS3c0REFob0ZBREFqQmdrcWhraUc5dzBCQndHZ0ZnUVVrUjhqMTRlTDBMcHVpWmxWeGsrREoyMk9oWTB4Z2Jrd2diWUNBUU9BRkNlN1hGZFB2WDQ1L2VMNzFoUjZCMHZjZmt5OE1Ba0dCU3NPQXdJYUJRQXdEUVlKS29aSWh2Y05BUUVCQlFBRWdZQ1ZTV0hZQ3RjK2NJZTY3UlpZcU9zWnNmOWlMVExpR0lLVWdNRU9nY3lPZXZuQ1NPY2ZRSURDQTZBR0NsZXNaNnQvOWJocGJHODNwNjlwKzFJeHFIeTZGc1FyakdSTlJ0Z1pJQ3NmYlV6WER0K0dKb1oxdmJNYjZucFRmOFZxeGFPS0tUS3VtajMvRTkzZE1Hd3dLVFBkRm8vR2htQTJxbk5WS1o2ZzY3QWRodz09Pg==" } do |response, request, result, &block|
 #                 case response.code
 #                   when 201 
 #                       p "ok"
 #                   else
 #                     puts response.inspect
 #                 end 
 #               end 
 # end

  def test_form_fileds
    options = {:redirectUrl => "http://test.url.com", :transationId => "12d1d12d12d2", :amount => 1150, :orderNumber => 44}
    result = GATEWAY.setup_authorization(options)
    assert result["SetupString"] =~ /.{10,}/, "VALUE of setup string is incorrect" # value must have proper length
    assert result.is_a?(Hash), "Result should be a hash"
  end
end
