class Expense < ActiveRecord::Base
	belongs_to :renter
	validates :amount, numericality: true

	def self.total
		sum = 0

		self.all.each do |expense|
			sum += expense.amount
		end

		return sum
	end

	def self.perPerson
		pp = total / Renter.all.count.to_f
		return pp
	end

	def edit?(user)
		if not user
			return false
		elsif user.admin?
			return true
		elsif renter.to_s == user.to_s
			return true
		end

		return false
	end


end
