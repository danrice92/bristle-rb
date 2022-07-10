class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: {unique: true}
      t.string :verification_code
      t.boolean :email_verified, null: false, default: false, index: true

      t.timestamps
    end
  end
end
