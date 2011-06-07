class PeopleController < ApplicationController
  before_filter :find, :only=>[:show, :edit, :update, :destroy]


  def index
    @people = Person.order(:last_name)
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      redirect_to people_url
      return
    end
    render :action=>:new
  end

  def edit
    title :label=>@person.label
    render :action=>:new
  end

  def update
    if @person.update_attributes(params[:person])
      redirect_to people_url
      return
    end    
    title :label=>@person.label
    render :action=>:new
  end

  def destroy
    @person.destroy
  end

  protected

  def find()
    unless @person = Person.find_by_name(params[:id])
      notify(:inexistent_person, :error)
      redirect_to root_url
      return false
    end
  end



end
