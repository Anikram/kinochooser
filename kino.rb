#encoding:utf-8
# Kinochooser by Anikram 08.12.2017
# Программа для выбора кино из списка top500 на сайте http://www.kinopoisk.ru/top/

require 'mechanize'
require 'launchy'

agent = Mechanize.new()


chosen = false

until chosen == true
  begin
  page = agent.get("https://www.kinopoisk.ru/top/lists/1/filtr/all/sort/order/perpage/100/page/#{rand(5)+1}")
  rescue SocketError => exception
    puts exception
    abort('Не удалось подключиться к серверу')
    end
  tr_tag = page.search("//tr[starts-with(@id, 'tr_')]").to_a.sample


  film_title = tr_tag.search("a[@class='all']").text
  film_rang = tr_tag.search("div[@class='num rangImp']").text
  kinopoisk_rating = tr_tag.search("span[@class='all']").text
  kinopoisk_id = tr_tag.attributes['id'].text.tr!('tr_','')
  kinopoisk_link = "https://www.kinopoisk.ru/film/#{kinopoisk_id}/"
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

  puts 'Какую страницу открыть?'
  puts "1. Кинопоиск;"
  puts "2. РуТрекер?"

  user = STDIN.gets.chomp.to_i

  if user == 1
  Launchy.open(kinopoisk_link)
  elsif user == 2
  Launchy.open("https://rutracker.org/forum/tracker.php?nm=#{film_title}")

  else
    puts 'Простите, не понятно...'
    puts
  end
  puts 'Приятного просмотра!'
else
  puts
  puts
  puts
  puts
end

end
