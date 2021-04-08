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
    elsif response.code == 429
      redirect_to root_path, alert: 'Too Many Requests'
    else
      redirect_to root_path, alert: 'Character Not Found'
    end
  end

  def index
    @busqueda = search(params[:search])
  end

  def search(s)
    if s
      name = params[:search].split(" ")
      ur = name.join("+")
      url_characters = 'https://tarea-1-breaking-bad.herokuapp.com/api/characters/?name=%s' % ur
      chars = HTTP.get(url_characters)
      if chars.status.success?
        $search_characters = JSON.parse(chars)
        if $search_characters.nil?
          redirect_to root_path, alert: 'Character Not Found'
        end
      elsif chars.code == 429
        redirect_to root_path, alert: 'Too Many Requests'
      else
        redirect_to root_path, alert: 'Character Not Found'
      end
    end
  end

  private

  def char_params
    params.permit(:name, :search)
  end
end
