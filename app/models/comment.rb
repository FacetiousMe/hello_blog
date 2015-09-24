class Comment < ActiveRecord::Base
  belongs_to :article	# Each Comment belongs to one Article.
end
