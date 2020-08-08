class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :image_url

      t.timestamps
    end

    add_index :users, %i[provider uid], unique: true
  end
end