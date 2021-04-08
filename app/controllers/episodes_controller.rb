require 'http'
require 'json'

class EpisodesController < ApplicationController
  before_action :calendario, only: %i[show]
  
  def calendario
    $calendario = {'01' => 'January', '02' => 'February', '03' => 'March', '04' => 'April', '05' => 'May',
                   '06' => 'June', '07' => 'July', '08' => 'August', '09' => 'September', '10' => 'October', 
                   '11' => 'November', '12' => 'December'}
  end
  
  def show
    url_episode = 'https://tarea-1-breaking-bad.herokuapp.com/api/episodes/'
    id_episodio = params[:id]
    url = url_episode + id_episodio
    response = HTTP.get(url)
    if response.status.success?
      @episode = JSON.parse(response)[0]
      if @episode.nil?
        redirect_to root_path, alert: 'Episode Not Found'
      else
        @serie = @episode['series']
        fecha = (@episode['air_date'].split('T')[0]).split('-')
        @date = '%s %s, %s' %[fecha[2], $calendario[fecha[1]], fecha[0]]
      end
    elsif response.code == 429
      redirect_to root_path, alert: 'Too Many Requests'
    else
      redirect_to root_path, alert: 'Episode Not Found'
    end
  end
end