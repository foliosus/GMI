class ContactForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /^$|^\S+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,4}|[0-9]{1,4})(\]?)$/ix
  attribute :subject,   :validate => true
  attribute :message,   :validate => true
  attribute :nickname,  :captcha => true
  
  OFFICE_EMAIL = 'gmioffice@me.com'
  DEVELOPER_EMAIL = 'foliosus@foliosus.com'
  
  def headers
    { :subject => "[GMI] #{subject}",
      :to => Rails.env.dev? ? DEVELOPER_EMAIL : OFFICE_EMAIL,
      :respond_to => %("#{name} <#{email}"),
      :from => OFFICE_EMAIL }
  end
end
