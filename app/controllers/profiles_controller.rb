class ProfilesController < ApplicationController
  def index
    if !signed_in?
      render('loggedout')
    end
    @profiles = Profile.all
  end

  def new
    if !signed_in?
      render('loggedout')
    end
    user_id = current_user.id
    if Profile.find_by user_id: user_id
      profile = Profile.find_by user_id: user_id
      redirect_to(profile_path(profile))
    end
    @profile = Profile.new
  end

  def create
    filter = p
    @profile = Profile.new(profile_params)
    if @profile.save!
      redirect_to(profiles_path, {:flash => {:green => "Profile created successfully."}})
    else
      render("new")
    end
  end

  def edit
	@profile = Profile.find(params[:id])
    if !signed_in?
      render('loggedout')
    end
  end
  
  def update
	@profile = Profile.find(params[:id])
	if @profile.update(profile_params)
		redirect_to(profiles_path, {:flash => {:green => "Profile updated succesfully."}})
	else
		render('edit')
	end
  end

  def show
    @profile = Profile.find(params[:id])
    if !signed_in?
      render('loggedout')
    end
  end
 
  def delete
    @profile = Profile.find(params[:id])
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to(profiles_path, {:flash => {:red => "Profile deleted successfully."}})
  end

  def loggedout
  end

  private def profile_params() 
    params.require(:profile).permit(:name, :email, :phonenumber, :snapchat, :instagram, :facebook, :twitter, :ptanimal, :pttruecolors, :ptmyersbriggs, :aboutme, :approvedchair, :gender, :user_id)
  end
end