require "active_support/concern"
require "browser"

module BrowserSenseFilter
  extend ActiveSupport::Concern

  included do
    def self.browser_sense
      # monitor which browser is being used
      # stored in csv format in the log for each method invocation, extract with:
      # grep BrowserSense development.log | cut -f2- -d:
      before_action do |controller|
        user_agent = request.env["HTTP_USER_AGENT"]
        ip = request.env["REMOTE_ADDR"]

        hashed_ip = Digest::SHA256.hexdigest ip
        b = Browser.new(user_agent)
        now = DateTime.now

        logger = Rails.logger
        browser_data = [
          b.name, b.platform, b.device.name,
          controller.class.name, controller.action_name,
          request.format.symbol,
          hashed_ip,
          now
        ]

        browser_data_str = browser_data.map { |x| "\"#{x}\"" }.join(",")
        logger.info "BrowserSense: #{browser_data_str}"
      end
    end
  end
end
