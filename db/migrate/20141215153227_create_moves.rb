class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.string :mark
      t.integer :user_id
      t.integer :position
      t.integer :ttt_id

      t.timestamps
    end
  end
end
