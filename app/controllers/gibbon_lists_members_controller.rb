class GibbonListsMembersController < ApplicationController
  def index
    @list_id = params[:gibbon_list_id]
    start = params[:start] || 0
    limit = params[:limit] || 100
    @members = GibbonAPI.list_members({:id => @list_id, :start => start, :limit => limit})
    
    
  end

  def show
    @list_id = params[:gibbon_list_id]
    @email = params[:email]
    @member = GibbonAPI.list_member_info({:id => @list_id, :email_address => @email})
  end

  def create
    @list_id = params[:gibbon_list_id]
    @email_address = params[:email_address]

    # see http://apidocs.mailchimp.com/rtfm/listsubscribe.func.php
    if GibbonAPI.list_subscribe({
      :id => @list_id,
      :email_address => @email_address,
      #:merge_vars => {},
      #:email_type => "html", # optional - email type preference for the email (html, text, or mobile defaults to html)
      #:double_optin => true,
      #:update_existing => true,
      #:replace_interests => false,
      #:send_welcome => true,
    })
      flash[:info] = "successfully subscribed, a confirmation email will be sent to yo shortly"
    else
      flash[:error] = "subscribe failed"
    end

    redirect_to gibbon_list_members_path(@list_id)
  end

  def destroy
    @list_id = params[:gibbon_list_id]
    @email_address = params[:email_address]

    # see http://apidocs.mailchimp.com/rtfm/listunsubscribe.func.php
    if GibbonAPI.list_unsubscribe({
      :id => @list_id,
      :email_address => @email_address,
      #:delete_member=> false,
      #:send_goodbye => true,
      #:send_notify => true,
    })
      flash[:info] = "successfully unsubscribed"
    else
      flash[:error] = "unsubscribe failed"
    end

    redirect_to gibbon_list_members_path(@list_id)
  end

end
