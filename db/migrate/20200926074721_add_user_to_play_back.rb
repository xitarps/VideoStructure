class AddUserToPlayBack < ActiveRecord::Migration[6.0]
  def change
    add_reference :play_backs, :user, null: false, foreign_key: true
  end
end
