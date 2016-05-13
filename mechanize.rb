require 'rubygems'
require 'mechanize'

#search for these items on Wikipedia
search_terms = ['steve jobs', 'elon musk', 'larry page', 'mark zuckerburg']

#setup Mechanize
agent= Mechanize.new { |agent|
  agent.user_agent_alias = 'Windows Chrome'
}

#setup the page
page = agent.get('https://www.wikipedia.org/')
search_form = page.form(:action => '//www.wikipedia.org/search-redirect.php')

search_terms.each do |term|
  search_form.search = term
  results = agent.submit(search_form, search_form.button('go'))
  html_results = Nokogiri::HTML(results.body)
  name = html_results.at_css('#firstHeading').text
  bday = html_results.at_css('.bday').text
  puts name + " was born on " + bday
end




# name = html_results.at_css('#firstHeading').text
# bday = html_results.at_css('.bday').text
# dday = html_results.at_css('.dday').text

# puts name, bday, dday