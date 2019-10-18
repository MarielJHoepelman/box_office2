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
      puts "Welcome to the Box Office"
      puts "Please select your movie or enter 0 for exit"
      puts "========================="
      puts ""
    end

    def movie_list
      @list ||= BoxOffice2::MovieList.new.list
      @list.each_with_index do |movie, index|
        puts "#{index + 1}. #{movie[:title]}"
      end
    end

    def menu_options
      @selection = nil

      while @selection != 0 do
        @selection = gets.strip.to_i

        if @selection.between?(1, @list.count)
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
      movie = BoxOffice2::Movie.find_or_create(@list[@selection - 1])

      puts movie.title
      puts ""
      puts movie.description
      puts ""
      continue_menu
    end

    def continue_menu
      puts "Would you like to go back to the main menu?"
      input = gets.strip

      if input.downcase == "y"
        start
      else
        puts "bye"
        exit
      end
    end
  end
end
