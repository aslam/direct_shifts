class CreateReferrals < ActiveRecord::Migration[7.1]
  def change
    create_table :referrals do |t|
      t.string :email, null: false
      t.references :inviter, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :referrals, :email, unique: true
  end
end
