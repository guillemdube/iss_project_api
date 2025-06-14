class SatellitesController < ApplicationController
    
    def index
        if Satellite.first.nil?
            response = HTTParty.get('https://api.wheretheiss.at/v1/satellites')
            if response.code == 200
                satellite_data = JSON.parse(response.body)
                Satellite.where(:name_sat => satellite_data[0]['name'])
                .first_or_create(:name_sat => satellite_data[0]['name'], :id_sat => satellite_data[0]['id'])
            else 
                render json: {message: response.error}, status: :not_found
            end
        end
        satellite = Satellite.first
        render json: [satellite], status: :ok
    end
end
  