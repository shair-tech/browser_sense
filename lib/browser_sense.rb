# frozen_string_literal: true

require_relative "browser_sense/version"

module BrowserSense
  #
  # Mount us as an Engine
  # (or the Rails app will know nothing about us)
  #
  class Engine < ::Rails::Engine
  end
end
