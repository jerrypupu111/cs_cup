class MembersController < ApplicationController
	def show
		@member = Member.find(params[:id])
	end

	def create
		
		@user = User.find(params[:member][:uid])
		@user.members.create(member_params)
		redirect_to @user
	end
	def index
		#@user = User.find(params[:user_id])
		#@members = @user.members
		@members = Member.filter(params.slice(:filter_name))
	end
	def update
		
		@member = Member.find(params[:id])
		@user = User.find(@member.user_id)

		respond_to do |format|
		    if @member.update_attributes(member_params)
		    	puts member_params
		      format.html { redirect_to(@user) }
		      format.json { respond_with_bip(@member) }
		    else
		      format.html { render :action => "edit" }
		      format.json { respond_with_bip(@user) }
		    end
	  	end
	end

	def destroy
		@member = Member.find(params[:id])
		@member.destroy
		@user = User.find(@member.user_id)

		redirect_to @user
	end
	def member_params
		params.require(:member).permit(:image,:studentidcardfront,:studentidcardback,:idcardback,:idcardfront,:name,:person_id,:birthday,:school_id,:cellphone,:etc, :isGifted)
	end
end
