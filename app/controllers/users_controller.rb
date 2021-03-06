class UsersController < ApplicationController
	
	def index
		#@users = User.all.order('created_at DESC')
		@users = User.filter(params.slice(:sport,:money_transfered,:confirm_state,:fbname))
=begin		
		if params[:searchbar]==nil
			puts 'nil search'
			@users = User.all.order('created_at DESC')
		else
  			@users = search
  		end
=end
	end
	def show
		@user = User.find(params[:id])
	end
	def update
	    @user = User.find(params[:id])
	    respond_to do |format|
		    if @user.update_attributes(user_params)
		      format.html { render(@user, :notice => 'User was successfully updated.') }
		      format.json { respond_with_bip(@user) }
		    else
		      format.html { render :action => "edit" }
		      format.json { respond_with_bip(@user) }
		    end
	  	end
	    #
	    #if @user.update_attributes(user_params)
	    #	respond_with @user
		#end
  	end
  	
  	def send_email
		UserMailer.confirm(params).deliver_later!
		if(params[:success]==true)
			@user = User.find(params[:id])
			@user.confirm_state = "mailed"
			@user.save
		end
    	redirect_to :back
	end
  	def search
  			@users = User.search(params[:searchbar])
  	end
  	def user_params
		params.require(:user).permit(:email,:name, :school, :sport, :department, :transfercode,:captain,:confirm_state,:has_insurance)
	end

	

end
