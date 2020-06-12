class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :resources_not_found

  protected

  def resources_not_found
  end
end
