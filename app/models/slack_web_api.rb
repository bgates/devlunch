class SlackWebApi
  
  class << self 
    def find_user(user_id)
      Slack::Web::Client.new.users_info(user: user_id)
    end
  end
end