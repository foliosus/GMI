class HoldingController < ApplicationController
  caches_page :index
  
  def index
    @contact_form = ContactForm.new
  end
  
  def process_email
    @contact_form = ContactForm.new(params[:contact_form])
    respond_to do |format|
      format.html do
        @contact_form.deliver if @contact_form.valid?
        render :action => :index
      end
      format.js do
        if @contact_form.valid?
          @contact_form.deliver
          render :text => '<p class="response">Thanks for the message! We\'ll be in touch soon.</p>'
        else
          render :partial => 'email_form', :layout => false, :status => :ok
        end
      end
    end
  end
end
