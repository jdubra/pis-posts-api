# frozen_string_literal: true

json.error do
  json.messages @messages
  json.status response.status
end
