# frozen_string_literal: true

# обработка несуществующих роутов и форматов
class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, with: :render_not_found_err
  rescue_from ActionController::UnknownFormat, with: :render_not_found_err

  def render_not_found_err
    render json: { error: 'Route not found' }, status: :not_found
  end
end
