class PetitionsController < ApplicationController

  def index    
  end

  def new
    @petition = Petition.new
    render_form
  end

  def create
    @petition = Petition.new(params[:petition])
    @petition.creator = @petition.updater = current_user
    if @petition.save
      redirect_to petitions_url
    end
    render_form
  end

  def edit
    @petition = Petition.find_by_name(params[:id])
    render_form
  end

  def update
    @petition = Petition.find_by_name(params[:id])
    @petition.updater = current_user
    if @petition.update_attributes
      redirect_to petitions_url
    end    
    render_form
  end

  def destroy
    Petition.find_by_name(params[:id]).destroy
  end

end
