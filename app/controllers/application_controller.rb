# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActionController::UnknownFormat, with: :render_404

  def render_404
    render json: { error: 'Route not found' }, status: :not_found
  end
end