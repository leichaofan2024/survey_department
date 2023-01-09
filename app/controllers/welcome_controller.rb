class WelcomeController < ApplicationController

  def index
    flash[:warning] = "hahah"
    Rails.logger.info "这是啥：#{flash[:warning]}"
  end

end
