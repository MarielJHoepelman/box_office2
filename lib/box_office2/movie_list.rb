module BoxOffice2
  class MovieList
    attr_reader :list

    def initialize
      @list = scrape_imdb
    end

    def scrape_imdb
      doc = BoxOffice2::Scrapper.scrapper("chart/boxoffice")
      movies_list = doc.css(".chart .titleColumn")

      movies_list.map do |movie|
        {
          title: movie.text.strip,
          url: movie.css("a").attribute("href").value
        }
      end
    end
  end
end
