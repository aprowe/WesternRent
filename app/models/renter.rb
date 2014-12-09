require 'bcrypt'

class Renter < ActiveRecord::Base
	belongs_to :room, -> {where rentable: true}
	has_many :expenses

	before_save :hash_new_password, :if=>:password_changed?
	attr_accessor :new_password
	validates_confirmation_of :new_password, :if=>:password_changed?

	def password_changed?
    	!@new_password.blank?
    end

	def hash_new_password
		self.password = BCrypt::Password.create(@new_password)
	end

	def self.authenticate(username, password)

	  if user = find_by_username(username)

	  	if user.new_password?
	  		@new_password = password
	  		user.save
	  		return user
	  	end

	    if BCrypt::Password.new(user.password).is_password? password
	      return user
	    end
	  end

	  return nil
	end

	def new_password?
		self.password.length < 5
	end

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
		return (House.first.rent.id == id)
	end


	def utilities?
		return (id == House.first.utilities.id)
	end

	def image_path
		
		if File.exist?("#{Rails.root}/public/uploads/#{self.id}.png")
			return "/uploads/#{self.id}.png"
		else
			return '/uploads/default.png'
		end
	end


end
