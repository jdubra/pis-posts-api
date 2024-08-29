# frozen_string_literal: true

json.extract! user, :id, :username, :email, :created_at, :updated_at
json.posts user.posts do |post|
  json.partial! 'api/v1/posts/post', post:
end
