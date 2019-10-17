module BoxOffice2
  class MovieList
    attr_reader :list

    def initialize
      @list = scrape_imdb
    end

    def scrape_imdb
      doc = Nokogiri::HTML(open('https://www.imdb.com/chart/boxoffice'))
      movies_list = doc.css(".chart .titleColumn")

      movies_list.map do |movie|
        {
          title: movie.text.strip
        }
      end
    end
  end
end
