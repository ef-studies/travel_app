#TODO Api aeroportos
class TravelsController < ApplicationController
API_BASE = "http://localhost/api/v0/travels/"

  def index
    response = HTTParty.get(API_BASE)
    @travels = JSON.parse(response.body)
  end

  def new
    @travel = new_travel
  end

  def create
    response = HTTParty.post(API_BASE, body: { travel: travel_params })

    if response.code == 200
      redirect_to travels_path
    else
      render :new
    end
  end

  def edit
    response = HTTParty.get("#{API_BASE}#{params['id']}")
    @travel = JSON.parse(response.body).symbolize_keys!
  end

  def update
    @travel = travel_params
    @travel[:id] = params['id']

    response = HTTParty.patch("#{API_BASE}#{params['id']}", body: { travel: @travel })

    if response.code == 200
      redirect_to travels_path
    else
      render :edit
    end
  end

  def destroy
    HTTParty.delete("#{API_BASE}#{params['id']}")
    redirect_to travels_path
  end

  private

  def travel_params
    params.require(:travel).permit(:id, :destination, :origin, :departure_date,
      :return_date)
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