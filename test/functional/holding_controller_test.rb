require 'test_helper'

class HoldingControllerTest < ActionController::TestCase
  should "get index" do
    get :index
    assert_response :success
    assert_template :index
  end
  
  should "post an incomplete form" do
    xhr :post, :process_email, :contact_form => {name: 'John', email: 'test@example.com', subject: 'Hello'}
    assert_response :success
    assert_template :email_form
    assert_select 'form'
  end
  
  should "post a complete form" do
    xhr :post, :process_email, :contact_form => {:name => 'John', :email => 'test@example.com', :subject => 'Hello', :message => 'Hello!'}
    assert_response :success
    assert_match 'Thanks', @response.body
    assert_select 'p.response'
  end

end
