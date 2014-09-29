ActiveAdmin.register Room do

  permit_params :description, :rent, :area, :rentable, :renter_id
  form do |f|
    f.inputs # Include the default inputs
    f.inputs "Categories" do
      f.input :factors, as: :check_boxes, collection: Factor.all
    end
    f.actions # Include the default actions
  end

	controller do

    	def update

          logger.debug params[:room][:area]
        	room = Room.find(params[:id])
        	room.factors.delete_all
        	factors = params[:room][:factor_ids]
        	factors.shift
        	factors.each do |factor_id|
          	  room.factors << Factor.find(factor_id.to_i)
        	end

          room.area = params[:room][:area]
          room.rent = params[:room][:rent]
          room.rentable = params[:room][:rentable]
          room.save

        redirect_to resource_path(room)
    	end
	end
end
