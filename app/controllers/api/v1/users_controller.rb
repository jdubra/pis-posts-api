# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include RenderErrorHelper

      def create
        @user = User.new(user_params)
        if @user.save
          render :show, status: :created
        else
          render_error(@user.errors.full_messages, :unprocessable_entity)
        end
      end

      def index
        @users = User.all
        render :index
      rescue StandardError => e
        render_error(e.message, :internal_server_error)
      end

      def show
        @user = User.find(params[:id])
        render :show
      rescue ActiveRecord::RecordNotFound
        render_error('User not found', :not_found)
      end

      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          render :show, status: :ok
        else
          render_error(@user.errors.full_messages, :unprocessable_entity)
        end
      rescue ActiveRecord::RecordNotFound
        render_error('User not found', :not_found)
      end

      def destroy
        @user = User.find(params[:id])
        @user.destroy
        render :destroy, status: :ok
      rescue ActiveRecord::RecordNotFound
        render_error('User not found', :not_found)
      end

      private

      def user_params
        params.permit(:username, :email)
      end
    end
  end
end
