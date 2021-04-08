class CharactersController < ApplicationController
  def show
    name = params[:name].split('%')
    puts(name)
    ur = name.join("+")
    puts(ur)
    url_character = 'https://tarea-1-breaking-bad.herokuapp.com/api/characters/?name=%s' % ur
    puts(url_character)
    @character = JSON.parse(HTTP.get(url_character).body)[0]
    puts(@character)
  end

  def search
  end
end
