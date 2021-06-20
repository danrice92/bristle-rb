class CreateInitialTables < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: {unique: true}
      t.string :auth_token
      t.boolean :email_verified, null: false, default: false, index: true

      t.timestamps
    end

    create_table :employers do |t|
      t.string :name, index: true
      t.string :industry

      t.timestamps
    end

    create_table :careers do |t|
      t.string :title, index: {unique: true}

      t.timestamps
    end

    create_table :user_careers do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :career, index: true, foreign_key: true

      t.timestamps
    end

    create_table :employments do |t|
      t.string :title, index: true
      t.date :start_date
      t.date :end_date
      t.decimal :starting_pay
      t.decimal :ending_pay

      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :employer, index: true, foreign_key: true
      t.belongs_to :user_career, index: true, foreign_key: true

      t.timestamps
    end

    create_table :locations do |t|
      t.string :address, index: true
      t.string :address2
      t.string :city, index: true
      t.string :state, index: true
      t.string :zipcode, index: true
      t.string :country, index: true

      t.belongs_to :user, optional: true
      t.belongs_to :employer, optional: true
      t.belongs_to :employment, optional: true

      t.timestamps
    end
  end
end
