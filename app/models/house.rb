class House < ActiveRecord::Base
    belongs_to :rent, class_name: 'Renter'
    belongs_to :utilities, class_name: 'Renter'

    # before_save :init

    attr_accessor :area

    def init 
    	@area = calc_area
    end

    def self.confirmed?
        return House.first.confirmed
    end

    def self.unconfirmed?
        return !House.first.confirmed
    end

    def calc_area
	    sum = 0

	    Room.all.each do |room|
			sum += room.area	    	
	    end

	    self.total_area = sum
	    self.save

	    return sum
    end
 
    def shared_area
        shared_area = 0
        Room.where.not(:rentable => true).each do |room|
            shared_area += room.area
        end

        return shared_area
    end

    def calc_total_rent

        total = 0
        Renter.all.each do |renter|
            total += renter.room.rent
        end

        return total
    end

    def assign_random
        trim = calc_total_rent
        i = rand(Renter.count).to_i
        j = Renter.count.to_i

        if calc_total_rent < total_rent
            while calc_total_rent < total_rent
                i += 1
                if i > j
                    i = 1
                end
                next unless Renter.offset(i).first
                room = Renter.offset(i).first.room
                room.rent += 1
                room.save

            end
        else
            while calc_total_rent > total_rent
                i += 1
                if i > j
                    i = 1
                end
                next unless Renter.offset(i).first
                room = Renter.offset(i).first.room
                room.rent -= 1
                room.save

            end
        end

        return calc_total_rent
    end

    def calc_rents


    	perinch = total_rent / calc_area


    	Room.where(:rentable => true).each do |room|
    		room.rent = room.area / room.num_renters + shared_area / Renter.count
            room.rent *= perinch
    		room.save
    	end

        Room.where(:rentable => true).each do |room|
            adjustment = 0
            room.factors.each do |factor|
                adjustment += factor.amount
            end


            other_rooms = Room.where(:rentable => true).where.not(id: room.id)

            other_rooms.each do |room2|
                logger.debug room2
                room2.rent -= adjustment / other_rooms.count
                room2.save
            end
            room.rent += adjustment / room.num_renters

            room.save
        end

        return assign_random


    end

    def reset_rent
        Renter.all.each do |renter|
            renter.paid = false
            renter.save
        end
    end


    def to_s
    	return "Western Court Castle"
    end

end
