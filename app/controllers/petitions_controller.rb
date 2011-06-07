class PetitionsController < ApplicationController
  before_filter :find_petition, :only=>[:show, :edit, :update, :destroy]

  def index
    @petitions = if current_user
                   Petition.order(:started_at)
                 else
                   Petition.where("active OR (published AND CURRENT_TIMESTAMP BETWEEN started_at AND stopped_at)").order(:started_at)
                 end
  end

  def show
    unless current_user
      unless @petition.active?
        redirect_to petitions_url
        return
      end
    end
    title :title=>@petition.title
  end

  def new
    @petition = Petition.new :started_at=>Time.now, :stopped_at=>Time.now, :commitment=>"Je soutiens cette initiative"
  end

  def create
    @petition = Petition.new(params[:petition])
    @petition.creator = @petition.updater = current_user
    if @petition.save
      redirect_to petitions_url
      return
    end
    render :action=>:new
  end

  def edit
    title :title=>@petition.title
    render :action=>:new
  end

  def update
    @petition.updater = current_user
    if @petition.update_attributes(params[:petition])
      redirect_to petition_url(@petition)
      return
    end    
    title :title=>@petition.title
    render :action=>:new
  end

  def destroy
    @petition.destroy
    redirect_to petitions_url
  end


  protected

  def find_petition()
    unless @petition = Petition.find_by_name(params[:id])
      notify(:inexistent_petition, :error)
      redirect_to root_url
      return false
    end
  end


end
