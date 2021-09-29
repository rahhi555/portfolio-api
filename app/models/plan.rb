class Plan < ApplicationRecord
  belongs_to :user
  has_many :roles, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :maps, dependent: :destroy
  has_many :svgs, -> { select 'svgs.*, plan_id' }, through: :maps
  has_many :todo_lists, dependent: :destroy
  has_many :todos, through: :todo_lists

  validates :name, presence: true, length: { maximum: 50 }

  # activeが変更されていればtodoのstatusも合わせて変更する
  def custom_update!(params)
    logger.ap params
    logger.ap params.include?(:active)
    logger.ap params[:active] == false
    ActiveRecord::Base.transaction do
      if params.include?(:active) && params[:active] == false
        todos.reset_status
      elsif params.include?(:active) && params[:active] == true
        todos.doing_status
      end
      update!(params)
    end
  end
end
