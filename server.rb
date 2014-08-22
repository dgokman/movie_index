require 'sinatra'
require 'sinatra/reloader'
    require 'csv'
    require 'pry'
     movies = []
      CSV.foreach('movies.csv', headers: true, header_converters: :symbol) do |row|
        movies << row.to_hash
      end



    get '/movies' do
      @movies = movies
      sorted_movies = @movies.sort_by {|key, value| key[:title] }
      @sorted_movies = sorted_movies
      @page = params[:page]
        if @page == nil || @page.to_i > (@sorted_movies.length / 20) + 1
         @next_page = 2
         @range_min = 0
         @range_max = 19
        else
         @next_page = @page.to_i + 1
         @range_min = (@page.to_i - 1)*20
         @range_max = @range_min + 19
        end
      @query = params[:query]
      @id = params[:id]
      @id_int = @id.to_i
      @search_results = @sorted_movies.find_all {|movie| @query == movie[:title] }
        #binding.pry

      erb :index
    end


    get '/movies/:id' do
      @id = params[:id]
      details = {}
      movies.each do |detail|
        details[detail[:id]] = [detail[:title], detail[:year], detail[:synopsis], detail[:rating],
        detail[:genre], detail[:studio]]
        #binding.pry
       end
        @title = details[@id][0]
        @year = details[@id][1]
        @synopsis = details[@id][2]
        @rating = details[@id][3]
        @genre = details[@id][4]
        @studio = details[@id][5]
      erb :movie_id
      #binding.pry
    end




