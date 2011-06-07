class Activator < ActionMailer::Base

  def confirmation(signature, url)
    @signature, @url = signature, url
    @petition  = @signature.petition
    mail(:to=>@signature.email, :from=>@petition.sender, :subject=>"[#{@petition.title}] Confirmation de votre signature")
  end

end
