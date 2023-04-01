class CreateInclinometers < ActiveRecord::Migration[7.0]
  def change
    create_table :inclinometers do |t|

      t.timestamps
    end
  end
end
