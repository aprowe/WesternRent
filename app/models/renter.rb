class Renter < ActiveRecord::Base
	belongs_to :room, -> {where rentable: true}
	has_many :comments;
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

	def status 
		if self.paid
			return 'paid'
		else
			return 'unpaid'
		end
	end

	def image_path
		
		if File.exist?("#{Rails.root}/public/uploads/#{self.id}.png")
			return "/uploads/#{self.id}.png"
		else
			return '/uploads/default.png'
		end
	end


end
