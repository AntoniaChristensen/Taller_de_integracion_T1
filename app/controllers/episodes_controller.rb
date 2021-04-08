require 'http'
require 'json'

class EpisodesController < ApplicationController
  def show
    url_episode = 'https://tarea-1-breaking-bad.herokuapp.com/api/episodes/'
    id_episodio = params[:id]
    @serie = params[:serie]
    url = url_episode + id_episodio
    @episode = JSON.parse(HTTP.get(url).body)[0]
  end
end
