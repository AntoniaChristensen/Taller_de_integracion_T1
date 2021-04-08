class SeasonsController < ApplicationController
  before_action :get_episodios, only: %i[show home]

  def home
  end

  def show
    @episodios = {}
    if params[:serie] == "BB"
      @temp = $temporadas_bb[params[:id]]
      if @temp.nil?
        redirect_to root_path, alert: 'Season Not Found'
      else
        @serie = "Breaking Bad"
        $response_episodios_bb.each do |episode|
          @episodios[episode["title"]] = episode["episode_id"]
        end
      end
    elsif params[:serie] == "Saul"
      @serie = "Better Call Saul"
      @temp = $temporadas_saul[params[:id]]
      if @temp.nil?
        redirect_to root_path, alert: 'Season Not Found'
      else
        $response_episodios_saul.each do |episode|
          @episodios[episode["title"]] = episode["episode_id"]
        end
      end
    else
      redirect_to root_path, alert: 'TV Series Not Found'
    end
  end

  def get_episodios
    url_episodes_breaking_bad = 'https://tarea-1-breaking-bad.herokuapp.com/api/episodes?series=Breaking+Bad'
    url_episodes_better_call_saul = 'https://tarea-1-breaking-bad.herokuapp.com/api/episodes?series=Better+Call+Saul'
    $response_episodios_bb = JSON.parse(HTTP.get(url_episodes_breaking_bad).body)
    $response_episodios_saul = JSON.parse(HTTP.get(url_episodes_better_call_saul).body)
    $temporadas_bb = {}
    $response_episodios_bb.each do |episode|
      if $temporadas_bb.has_key?(episode["season"])
        $temporadas_bb[episode["season"]].append(episode["title"])
      else
        $temporadas_bb[episode["season"]] = []
        $temporadas_bb[episode["season"]].append(episode["title"])
      end
    end
    $temporadas_saul = {}
    $response_episodios_saul.each do |episode|
      if $temporadas_saul.has_key?(episode["season"])
        $temporadas_saul[episode["season"]].append(episode["title"])
      else
        $temporadas_saul[episode["season"]] = []
        $temporadas_saul[episode["season"]].append(episode["title"])
      end
    end
  end
end
