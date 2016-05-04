class RemoveAutorFromPublicacoes < ActiveRecord::Migration
  def change
    remove_column :publicacoes, :autor, :string
  end
end
