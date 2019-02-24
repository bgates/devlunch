class Locator
  YELP_API_URL = "https://api.yelp.com/v3/businesses/search"
  YELP_API_KEY = Devlunch::Application.credentials.yelp_api_key
  
  def self.run(term)
    response = HTTParty.get(YELP_API_URL, yelp_request_params(term))
    results = JSON.parse response, symbolize_names: true
    return results[:businesses][0]
  end

  private 

  def self.yelp_request_params(term)
    {
      query: { term: term, location: "Orlando, FL" }, 
      format: :plain, 
      headers: { Authorization: "Bearer #{YELP_API_KEY}"}
    }
  end
end