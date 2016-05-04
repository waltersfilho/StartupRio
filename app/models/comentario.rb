class Comentario < ActiveRecord::Base
  belongs_to :publicacao
  belongs_to :user
  validates :user,
            presence: true
  validates :publicacao,
            presence: true

  acts_as_votable
end
