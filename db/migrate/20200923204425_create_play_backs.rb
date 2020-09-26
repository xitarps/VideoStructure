class CreatePlayBacks < ActiveRecord::Migration[6.0]
  def change
    create_table :play_backs do |t|
      t.string :title
      t.string :url, default: 'https://'
      t.integer :views, default: 0

      t.timestamps
    end
  end
end
