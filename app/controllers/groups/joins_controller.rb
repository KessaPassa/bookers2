# frozen_string_literal: true

class Groups::JoinsController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    User::Group.create_or_destroy!(group:, user: current_user)
    redirect_to groups_path, notice: 'You have joined group successfully.' # rubocop:todo Rails/I18nLocaleTexts
  end
end
