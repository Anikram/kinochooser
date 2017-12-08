#encoding:utf-8
# Kinochooser by Anikram 08.12.2017
# Программа для выбора кино из списка top500 на сайте http://www.kinopoisk.ru/top/

require 'mechanize'

agent = Mechanize.new()


chosen = false

until chosen == true
  page = agent.get("https://www.kinopoisk.ru/top/lists/1/filtr/all/sort/order/perpage/100/page/#{rand(5)+1}")

  tr_tag = page.search("//tr[starts-with(@id, 'tr_')]").to_a.sample


  film_title = tr_tag.search("a[@class='all']").text
  film_rang = tr_tag.search("div[@class='num rangImp']").text
  kinopoisk_rating = tr_tag.search("span[@class='all']").text
  kinopoisk_link = "https://www.kinopoisk.ru/film/##{tr_tag.attributes['id']}/"
  film_description = tr_tag.search("span[@class='gray_text']")[0].text

  puts
  puts 'Мы выбрали для вас фильм:'
  puts "| Название: \"#{film_title}\" | \tРейтинг: #{kinopoisk_rating}. \t| #{film_rang} из 500."
  puts "#{film_description.chomp}"
  puts "-----------------------"
  puts "#{kinopoisk_link}"
  puts
  puts 'Хотите ли вы посмотреть фильм? (y/n)'
  user = STDIN.gets.chomp.to_s.downcase

if user == 'y'
  chosen = true
  puts 'Приятного просмотра!'
else
  puts
  puts
  puts
  puts
end

end
