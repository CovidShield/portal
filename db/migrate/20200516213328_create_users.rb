class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.boolean :admin, default: false
      t.string :locale, default: 'en'

      t.timestamps
    end
    add_index :users, :username, unique: true
  end

  def down
    drop_table :users
  end
end
