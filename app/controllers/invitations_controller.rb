class InvitationsController < ApplicationController
before_action :cors_preflight_check, only: :index
after_action :cors_set_access_control_headers, only: :index

  def create
    Invitation.create_from_yelp_data(params[:text], params[:user_id], params[:team_id], params[:user_name])
    render json: { response_type: "in_channel", text: "Thanks!" }
  end

  def destroy 
    @invitation = Invitation.where(slack_user_id: params[:user_id]).order("created_at DESC").first
    if @invitation
      @invitation.destroy
    end
  end

  def index 
    @invitations = Invitation.all.where(when: 1.hour.ago..DateTime::Infinity.new)
    respond_to do |format|
      format.html 
      format.json { render json: @invitations }
    end
  end

  def help 
    render json: { response_type: "in_channel", text: "Enter a restaurant name and time you plan to have lunch, e.g. `\lunch SuperRico at 12:30`. Your intention to go there will be publicly announced on https://devlunch.herokuapp.com. Anyone who is part of this Slack will be able to DM you to see if there's space at your table. If you entered something by mistake, just `\lunch cancel`."}
  end
  private 

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With auth_token X-CSRF-Token}.join(',')
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == "OPTIONS"
      cors_set_access_control_headers
      render :text => '', :content_type => 'text/plain'
    end
  end
end
