class SlackbotDeletion 
  def matches?(request)
    request.request_parameters[:text].match?(/cancel/)
  end
end

class SlackbotHelp 
  def matches?(request)
    request.request_parameters[:text].match?(/help/)
  end
end
Rails.application.routes.draw do
  root to: "invitations#index"
  post "invitations", to: "invitations#destroy", constraints: SlackbotDeletion.new
  post "invitations", to: "invitations#help", constraints: SlackbotHelp.new
  resources :invitations, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
