class ApplicationController < ActionController::Base
  before_action :get_work, only: [:show, :edit, :update]

end
