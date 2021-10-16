class AddUserIdToSvgs < ActiveRecord::Migration[6.0]
  def change
    add_reference :svgs, :user, null: true, foreign_key: true
  end
end
