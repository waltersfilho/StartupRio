class AddUserToPublicacoes < ActiveRecord::Migration
  def change
    add_reference :publicacoes, :user, index: true, foreign_key: true
  end
end
