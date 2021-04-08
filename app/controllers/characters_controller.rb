class CharactersController < ApplicationController
  def show
    name = params[:name].split('%')
    ur = name.join("+")
    url_character = 'https://tarea-1-breaking-bad.herokuapp.com/api/characters/?name=%s' % ur
    response = HTTP.get(url_character)
    if response.status.success?
      @character = JSON.parse(response)[0]
      if @character.nil?
        redirect_to root_path, alert: 'Character Not Found'
      else
        url_quote = 'https://tarea-1-breaking-bad.herokuapp.com/api/quote?author=%s' % ur
        @quotes = JSON.parse(HTTP.get(url_quote))
      end
    else
      redirect_to root_path, alert: 'Character Not Found'
    end
  end

  def search
  end
end
