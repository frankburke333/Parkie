class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.integer :parkactivity_id
      t.integer :user_id

      t.timestamps
    end
  end
end
