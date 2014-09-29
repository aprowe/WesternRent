class Factor < ActiveRecord::Base
	has_many :room_factors
	has_many :rooms, :through => :room_factors
	accepts_nested_attributes_for :room_factors
	# has_and_belongs_to_many :room

end
