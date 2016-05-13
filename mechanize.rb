require 'rubygems'
require 'mechanize'

# This program will search for the Wikipedia page listings for the individuals listed 
# in the search_terms array and return their full name, birth date, and day of death.
search_terms = ['george washington', 'benjamin franklin', 'thomas jefferson', 'john adams']

# Setup Mechanize
agent= Mechanize.new { |a|
  a.user_agent_alias = 'Windows Chrome'
}

# Setup the page. This will select the search box on Wikidedia.
page = agent.get('https://www.wikipedia.org/')
search_form = page.form(:action => '//www.wikipedia.org/search-redirect.php')

# For each item in the search_terms array do these things
search_terms.each do |term|
  search_form.search = term
  results = agent.submit(search_form, search_form.button('go'))
  html_results = Nokogiri::HTML(results.body)
  name = html_results.at_css('#firstHeading').text
  bday = html_results.at_css('.bday').text
  dday = html_results.at_css('.dday').text
  puts name + " was born on " + bday + " and died on " + dday
end

# Now run the file in the terminal. $ ruby mechanize.rb