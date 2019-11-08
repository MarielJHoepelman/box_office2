module BoxOffice2
  class MovieList
    attr_reader :list, :weekend_date

    def initialize
      @list = scrape_list
      @weekend_date = scrape_weekend_date
    end

    private
    
    def doc
      @doc ||= BoxOffice2::Scrapper.scrapper("chart/boxoffice")
    end

    def scrape_weekend_date
      doc.css("#boxoffice h4").text
    end

    def scrape_list
      movies_list = doc.css("table.chart.full-width td.titleColumn")

      movies_list.map do |movie|
        {
          title: movie.css("a").text,
          url: movie.css("a").attribute("href").value
        }
      end
    end
  end
end
