class TravelsController < ApplicationController

  def index
    response = HTTParty.get('http://localhost:3000/api/v0/travels')
    @travels = JSON.parse(response.body)
  end

  def new
  end

  def create
    response = HTTParty.post('http://localhost:3000/api/v0/travels', body: new_travel)
    if response.code == "200"
      redirect_to travels_path
    else
      redirect_to new_travel_path
    end
  end

  private

  def new_travel
    params.permit(:destination, :origin, :departure_date, :return_date)
  end
end