# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      include RenderErrorHelper

      def create
        @post = Post.new(post_params)
        if @post.save
          render :show, status: :created
        else
          render_error(@post.errors.full_messages, :unprocessable_entity)
        end
      end

      def index
        @posts = User.find(params[:user_id]).posts
        render :index
      rescue StandardError => e
        render_error(e.message, :internal_server_error)
      end

      def show
        @post = Post.find(params[:id])
        render :show
      rescue ActiveRecord::RecordNotFound
        render_error('Post not found', :not_found)
      end

      def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
          render :show, status: :ok
        else
          render_error(@post.errors.full_messages, :unprocessable_entity)
        end
      rescue ActiveRecord::RecordNotFound
        render_error('Post not found', :not_found)
      end

      def destroy
        @post = Post.find(params[:id])
        @post.destroy
        render :destroy, status: :ok
      rescue ActiveRecord::RecordNotFound
        render_error('Post not found', :not_found)
      end

      private

      def post_params
        params.permit(:title, :content, :user_id)
      end
    end
  end
end
