# frozen_string_literal: true

class GroupsController < ApplicationController
  def index
    @book = Book.new
    @groups = Group.all.preload(:owner, :members).with_attached_image
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
    render '403' unless @group.owner?(current_user)
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.group_users.build(user_id: current_user.id)
    if @group.save
      redirect_to groups_path, notice: 'You have created user successfully.' # rubocop:todo Rails/I18nLocaleTexts
    else
      render 'new'
    end
  end

  def update
    @group = Group.find(params[:id])
    render '403' unless @group.owner?(current_user)

    if @group.update(group_params)
      redirect_to groups_path, notice: 'You have updated user successfully.' # rubocop:todo Rails/I18nLocaleTexts
    else
      render 'edit'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
