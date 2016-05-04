class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.string :mensagem
      t.references :publicacao, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
