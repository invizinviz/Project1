class CreateTtts < ActiveRecord::Migration
  def change
    create_table :ttts do |t|
      t.integer :player_x_id
      t.integer :player_o_id
      t.integer :win_id

      t.timestamps
    end
  end
end
