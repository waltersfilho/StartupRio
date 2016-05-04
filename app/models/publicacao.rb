class Publicacao < ActiveRecord::Base
	has_many :comentarios
	belongs_to :user
	validates :user,
						presence: true

	acts_as_votable
end
