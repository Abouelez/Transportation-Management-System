class GetTrucksJob
  include Sidekiq::Job

  def perform(*args)
    uri = URI.parse("https://api-task-bfrm.onrender.com/api/v1/trucks")

    response = Net::HTTP.get_response(uri)
    
  end
end
