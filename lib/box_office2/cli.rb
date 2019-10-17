module BoxOffice2
  class CLI

    def call
      show_welcome
      movie_list
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
      movie_input
    end

    def movie_input
      input = gets.strip.to_i

      while input != 0 do
        puts "here"

      end
    end
  end
end
