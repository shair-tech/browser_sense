# frozen_string_literal: true

module BrowserSenseParser
  HEADERS = %i[
    browser platform device_name controller method
    request_format anon_ip timestamp
    ip browser_version platform_version
    bot search_engine bot_name
  ]

  def self.match?(line)
    /Browser(Sense|Info):/.match? line
  end

  def self.parse(line)
    begin
      csv_portion = line.gsub(/^.*Browser(Sense|Info): /, "")
      data = CSV.parse csv_portion, headers: HEADERS
      log_id = log_id(line)
      data.first.to_h.merge(log_id)
    rescue => exception
      Rails.logger.debug exception
      {}
    end
  end

  private_class_method def self.log_id(line)
    matchdata = /-- : \[(?<log_id>[a-f0-9-]+)\]/.match(line)

    { log_id: matchdata[:log_id] }
  end
end
