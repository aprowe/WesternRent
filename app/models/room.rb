class Room < ActiveRecord::Base
	has_many :renters
	has_many :room_factors
	has_many :factors, :through => :room_factors
	accepts_nested_attributes_for :room_factors,
		:allow_destroy => true
	# has_and_belongs_to_many :factor
	attr_accessor :factor_ids



	def num_renters
		renters = Renter.where(:room_id => self.id).count

		if renters == 0
			renters = 1
		end

		return renters
	end

	def to_s
		return self.description
	end
end
