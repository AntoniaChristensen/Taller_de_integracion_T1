require 'http'
require 'json'

class PagesController < ApplicationController
  def home
    url_episodes_breaking_bad = 'https://tarea-1-breaking-bad.herokuapp.com/api/episodes?series=Breaking+Bad'
    url_episodes_better_call_saul = 'https://tarea-1-breaking-bad.herokuapp.com/api/episodes?series=Better+Call+Saul'

    response_episodios_breaking_bad = JSON.parse(HTTP.get(url_episodes_breaking_bad).body)
    @temporadas_bb = {}
    @episodios_bb = {}
    response_episodios_breaking_bad.each do |episode|
      msg = "Temporada %s" % [episode["season"]]
      if @temporadas_bb.has_key?(msg)
        @temporadas_bb[msg].append(episode["title"])
        @episodios_bb[episode["title"]] = episode["episode_id"]
      else
        @temporadas_bb[msg] = []
        @temporadas_bb[msg].append(episode["title"])
        @episodios_bb[episode["title"]] = episode["episode_id"]
      end
    end

    response_episodios_saul = JSON.parse(HTTP.get(url_episodes_better_call_saul).body)
    @temporadas_saul = {}
    @episodios_saul = {}
    response_episodios_saul.each do |episode|
      msg = "Temporada %s" % [episode["season"]]
      if @temporadas_saul.has_key?(msg)
        @temporadas_saul[msg].append(episode["title"])
        @episodios_saul[episode["title"]] = episode["episode_id"]
      else
        @temporadas_saul[msg] = []
        @temporadas_saul[msg].append(episode["title"])
        @episodios_saul[episode["title"]] = episode["episode_id"]
      end
    end
  end
end