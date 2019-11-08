module BoxOffice2
  class CLI

    def call
      show_welcome
      start
    end

    def start
      movie_list
      menu_options
    end

    def show_welcome
      puts ""
      puts "\u{1F3A6} Welcome to the Box Office \u{1F3A6}".green
      puts "========================="
    end

    def movie_list
      @boxoffice_list ||= BoxOffice2::MovieList.new
      puts ""
      puts @boxoffice_list.weekend_date.yellow
      puts ""
      @boxoffice_list.list.each_with_index do |movie, index|
        puts "#{index + 1}. #{movie.title} (#{movie.gross})"
      end
      puts ""
      puts "Please select your movie or enter 0 for exit"
      puts ""
    end

    def menu_options
      @selection = nil

      while @selection != 0 do
        @selection = gets.strip.to_i

        if @selection.between?(1, @boxoffice_list.list.count)
          display_movie
        elsif @selection == 0
          exit
        else
          puts "This entry is invalid. Please enter a valid selection"
          menu_options
        end
      end
    end

    def display_movie
      movie = BoxOffice2::MovieDetails.find_or_create(@boxoffice_list.list[@selection - 1])
      puts "#{movie.status}"
      puts ""
      puts "Title: #{movie.title.yellow} #{movie.year}"
      puts ""
      puts "Rate: #{movie.rate.yellow}"
      puts ""
      puts "Description:"
      puts movie.description.yellow
      puts ""
      puts "Cast:"
      puts movie.cast
      puts ""
      continue_menu
    end

    def continue_menu
      puts "To see this movie in IMDB enter o"
      puts "Enter y to go back to main menu or n to exit"
      input = gets.strip

      if input.downcase == "y"
        start
      elsif input.downcase == "n"
        exit
      elsif input.downcase == "o"
        open_movie_in_browser
        continue_menu
      else
        puts "This entry is invalid. Please enter a valid selection"
        continue_menu
      end
    end

    def open_movie_in_browser
      movie = @boxoffice_list.list[@selection - 1]
      `open "#{BoxOffice2::Scrapper::IMDB_BASE_URL}#{movie.url}"`
    end
  end
end
