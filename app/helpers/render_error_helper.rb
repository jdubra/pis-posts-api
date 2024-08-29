# frozen_string_literal: true

module RenderErrorHelper
  def render_error(messages, status)
    @messages = Array(messages)
    render 'api/v1/shared/error', status:
  end
end
