class SignaturesController < ApplicationController

  before_filter :find_petition, :except=>[:index]

  def new
    return unless @petition
    @signature = @petition.signatures.new
  end

  def create
    return unless @petition
    @signature = @petition.signatures.new(params[:signature])
    @signature.ip_address = [request.ip, request.remote_ip, request.domain].join("#")
    if @signature.save
      Activator.confirmation(@signature, certify_petition_signature_url(@petition, @signature, :key=>@signature.hashed_key)).deliver
      notify(:confirmation_sent, :success)
      redirect_to petition_signatures_url(@petition)
      return
    else
      # raise  @signature.errors.inspect
    end
    render :action=>:new
  end

  def certify
    return unless @petition
    unless @signature = Signature.find_by_number_and_petition_id(params[:id], @petition.id)
      notify(:inexistent_signature, :error)
      redirect_to root_url
      return
    end
    if @signature.hashed_key == params[:key]
      notify(:signature_accepted, :success)
      @signature.update_attribute(:locked, false)
    else
      notify(:signature_corrupted, :error)
    end
    redirect_to petition_signatures_url(@petition)
  end

  def index
    unless @petition = Petition.find_by_name(params[:petition_id])
      notify(:inexistent_petition, :error)
      redirect_to root_url
      return false
    end
    title :count=>@petition.valid_signatures.count
  end

  protected
  
  def find_petition()
    unless @petition = Petition.find_by_name(params[:petition_id])
      notify(:inexistent_petition, :error)
      redirect_to root_url
      return false
    end
    unless @petition.signable?
      notify(:petition_no_longer_signable, :error)
      redirect_to root_url
      return false
    end
  end

end
