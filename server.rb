# require 'sinatra'
# require 'csv'
# require 'pry'
#   movies = []
#    CSV.foreach('movies.csv', headers: true, header_converters: :symbol) do |row|
#     movies << row.to_hash
#    end
#    #binding.pry
#   def get_title(movies)
#     titles = []
#     movies.each do |title|
#      titles << title[:title]
#     end
#     titles
#   end

#   get '/movies' do
#    #@movies = movies
#    @movie = get_title(movies)
#    erb :index
#    #binding.pry
#   end

require 'sinatra'
    require 'csv'
    require 'pry'
     movies = []
      CSV.foreach('movies.csv', headers: true, header_converters: :symbol) do |row|
        movies << row.to_hash
      end

    def get_title(movies)
      titles = []
      movies.each do |title|
        titles << title[:title]
      end
      titles
    end

    def get_ids(movies)
      ids = []
      movies.each do |id|
        ids << id[:id]
      end
      ids
    end


    get '/movies' do
      @movies = movies
      @titles = get_title(movies)
      @ids = get_ids(movies)
        @ids.each do |id|
          @idurl = id
        end
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



