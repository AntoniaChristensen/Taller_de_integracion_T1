class CharactersController < ApplicationController
  def show
    name = params[:name].split(' ')
    ur = name.join("+")
    url_character = 'https://tarea-1-breaking-bad.herokuapp.com/api/characters/?name=%s' % ur
    @character = JSON.parse(HTTP.get(url_character).body)
  end

  def search
  end
end
