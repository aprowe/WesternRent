class Renter < ActiveRecord::Base
	belongs_to :room, -> {where rentable: true}
	has_many :expenses
	# has_many :comments;
	# before_save :default


	def rent
		util = Utilities.last.perPerson

		expenses = Expense.perPerson

		paidFor = 0
		self.expenses.each do |e|
			paidFor += e.amount
		end

		return (self.room.rent + util + expenses - paidFor + 0.5).to_i
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
		if self.admin?
			return 'admin'
		end

		if self.paid
			return 'paid'
		else
			return 'unpaid'
		end
	end

	def admin?
		return (House.first.rent.to_s == self.name.to_s)
	end


	def utilities?
		return (self.name.to_s == House.first.utilities.to_s)
	end

	def image_path
		
		if File.exist?("#{Rails.root}/public/uploads/#{self.id}.png")
			return "/uploads/#{self.id}.png"
		else
			return '/uploads/default.png'
		end
	end


end
