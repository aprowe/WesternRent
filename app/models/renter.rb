class Renter < ActiveRecord::Base
	belongs_to :room, -> {where rentable: true}

	# before_save :default


	def rent
		return self.room.rent
	end

	def default_room
        self.room ||= Room.first
        self.picture ||= 'default.png'
    end

	def to_s
		return self.name
	end

	def default
		self.room ||= Room.first
		self.paid ||= false
	end


end
