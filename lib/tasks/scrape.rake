namespace :scrape do
  # this is a description of your task
  desc "Obtain school info"

  # this is your task function
  task :get_school_district => :environment do
    require 'open-uri'

    url = "http://www.edb.gov.hk/en/student-parents/sch-info/sch-search/schlist-by-district/index.html"
    link = open(url).read

    html_link = Nokogiri::HTML(link)

    links = html_link.css("div > div > div > p > a")

    links.each do |link|
        link = link.text.strip.gsub("*", "")

        if link.present?

         School.create(district: link)

        end
    end


  end

  task :get_school_name => :environment do
    require 'open-uri'

    url = "http://www.edb.gov.hk/en/student-parents/sch-info/sch-search/schlist-by-district/index.html"
    link = open(url).read

    html_link = Nokogiri::HTML(link)

    links_by_district = html_link.css("div > div > div > p > a").take(1)

    links_by_district.each do |link_elem|
      url2 = link_elem.attr('href')

      link2 = open(url2).read
      document = Nokogiri::HTML(link2)

      names = document.css("td:nth-child(2).bodytxt > table:nth-child(1) > tr:nth-child(1) > td:nth-child(1).bodytxt")

      names.each do |name|
        name = name.text.strip.gsub("*", "")

        if name.present?

          School.create(name: name)

        end
      end
    end
  end

  task :get_school_address => :environment do
    require 'open-uri'

    url = "http://www.edb.gov.hk/en/student-parents/sch-info/sch-search/schlist-by-district/index.html"
    link = open(url).read

    html_link = Nokogiri::HTML(link)

    links_by_district = html_link.css("div > div > div > p > a").take(1)

    links_by_district.each do |link_elem|
      url2 = link_elem.attr('href')

      link2 = open(url2).read
      document = Nokogiri::HTML(link2)

      addresses = document.css("td:nth-child(2).bodytxt > table:nth-child(1) > tr:nth-child(2) > td:nth-child(2).bodytxt")

      addresses.each do |address|
        address = address.text.strip.gsub("*", "")

        if address.present?
          puts address
        end
      end
    end
  end

  task :store_school_address => :environment do
    School.all.each do |school|
      record_data(school)
    end
  end

  def record_data(school)
    require 'open-uri'

    url = "http://www.edb.gov.hk/en/student-parents/sch-info/sch-search/schlist-by-district/index.html"
    link = open(url).read

    html_link = Nokogiri::HTML(link)

    links_by_district = html_link.css("div > div > div > p > a").take(1)

    links_by_district.each do |link_elem|
      url2 = link_elem.attr('href')

      link2 = open(url2).read
      document = Nokogiri::HTML(link2)

      addresses = document.css("td:nth-child(2).bodytxt > table:nth-child(1) > tr:nth-child(2) > td:nth-child(2).bodytxt")

      new_record = school.infos.new

      addresses.each do |address|
        address = address.text.strip.gsub("*", "")

        if address.present?

        end
      end
    end
  end


end