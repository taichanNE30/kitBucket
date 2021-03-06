class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from Exception, with: :render_500
  end

  def render_404
    render template: 'errors/404', status: 404, layout: 'application', content_type: 'text/html' if request.format == :html
  end

  def render_500
    render template: 'errors/500', status: 500, layout: 'application', content_type: 'text/html' if request.format == :html
  end
end
