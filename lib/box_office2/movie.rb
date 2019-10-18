module BoxOffice2
  class Movie
    attr_reader :title, :description, :rate, :year, :cast, :url

    @@all = []

     def initialize(item)
       @url = item[:url]
       @title = item[:title]
       scrape_movie
       @@all << self
     end

     def scrape_movie
       doc = BoxOffice2::Scrapper.scrapper(url)
       @description = doc.css(".summary_text").text.strip
       @year = doc.css("#titleYear").text.strip
       @rate = doc.css(".ratingValue").text.strip
       @cast = doc.css("tr.odd, tr.even")
     end

     def self.all
       @@all
     end

     def self.find_by_title(item)
       all.find{|movie| movie.title == item[:title]}
     end

     def self.find_or_create(item)
       find_by_title(item) || new(item)
     end
   end
 end
