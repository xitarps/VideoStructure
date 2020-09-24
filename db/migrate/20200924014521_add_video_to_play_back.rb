class AddVideoToPlayBack < ActiveRecord::Migration[6.0]
  def change
    add_column :play_backs, :video, :string
  end
end
