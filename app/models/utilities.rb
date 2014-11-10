class Utilities < ActiveRecord::Base

	def perPerson
		numRenters = Renter.count
		util = Utilities.last.amount

		util = util / numRenters.to_f
		return util
	end

end
