class CreatePublicacoes < ActiveRecord::Migration
  def change
    create_table :publicacoes do |t|
      t.string :autor
      t.string :titulo
      t.string :corpo

      t.timestamps null: false
    end
  end
end
