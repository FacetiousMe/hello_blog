class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy	# 1-to-many relationship

	validates :title, presence: true, length: { minimum: 1}
end
