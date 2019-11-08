module BoxOffice2
  class Movie
    attr_reader :title, :url, :gross

    def initialize(title, url, gross)
      @title = title
      @url = url
      @gross = gross
    end
  end
end
