class ApplicationController < ActionController::Base
  add_flash_types :warning
  add_flash_types :danger
  add_flash_types :success
end
