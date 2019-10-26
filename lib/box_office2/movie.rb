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

       doc_cast = doc.css("tr.odd, tr.even")
       @cast = doc_cast.map do |row|
         actor = row.css("td")[1].text.strip.gsub("\n","").squeeze(" ")
         role = row.css("td")[3].text.strip.gsub("\n","").squeeze(" ")
         "#{actor.yellow} as #{role.yellow}"
       end
     end

     def self.all_movies
       @@all
     end

     def self.find_by_title(item)
       all_movies.find do |movie|
         movie.title == item[:title]
       end
     end

     def self.find_or_create(item)
       find_by_title(item) || new(item)
     end
   end
 end
