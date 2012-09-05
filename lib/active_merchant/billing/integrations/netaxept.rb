require File.dirname(__FILE__) + '/netaxept/helper.rb'
require File.dirname(__FILE__) + '/netaxept/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Netaxept

        mattr_accessor :service_test_url
        self.service_test_url = 'https://epayment-test.bbs.no/terminal/default.aspx'

        # TODO change url for production
        mattr_accessor :service_production_url
        self.service_production_url = 'https://epayment-test.bbs.no/terminal/default.aspx'

        def self.service_url
          mode = ActiveMerchant::Billing::Base.integration_mode
          case mode
          when :production
            self.service_production_url
          when :test
            self.service_test_url
          else
            raise StandardError, "Integration mode set to an invalid value: #{mode}"
          end
        end

        def self.notification(post)
          Notification.new(post)
        end

        # TODO check this
        def self.return(query_string, options = {} )
          Return.new(query_string)
        end

        def self.string_setup
            add_field 'setup_string', collect_setup_string({:merchantId => account, :token => credential2, :serviceType => "B", :amount => amount, :currencyCode => currency, :redirectUrl => return_url, :orderNumber => order, :transactionId => "12d1t1212r21"})
        end

      end
    end
  end
end
