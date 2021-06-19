#TODO Api aeroportos
class TravelsController < ApplicationController

  def index
    response = HTTParty.get('http://localhost:3000/api/v0/travels')
    @travels = JSON.parse(response.body)
  end

  def new
    @travel = new_travel
  end

  def create
    response = HTTParty.post('http://localhost:3000/api/v0/travels', body: { travel: travel_params })
    if response.code == "200" || "302"
      redirect_to travels_path
    else
      redirect_to new_travel_path
    end
  end

  def edit
    response = HTTParty.get("http://localhost:3000/api/v0/travels/#{params['id']}")
    @travel = JSON.parse(response.body).symbolize_keys!
  end

  def update
  end

  def destroy
    HTTParty.delete("http://localhost:3000/api/v0/travels/#{params['id']}")
    redirect_to travels_path
  end

  private

  def travel_params
    params.require(:travel).permit(:destination, :origin, :departure_date, :return_date)
  end

  def new_travel
    {
      destination: '',
      origin: '',
      departure_date: Time.now.strftime("%Y-%m-%dT%H:%M"),
      return_date: Time.now.strftime("%Y-%m-%dT%H:%M")
    }
  end
end