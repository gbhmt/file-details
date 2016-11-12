# README

### Setup

Navigate to the project root in terminal and run `bundle install`.

Once all gems have been installed, run `bundle exec rails s`.


### Using the service

To upload a file and receive the total word count and a mapping of words and their respective counts, run the following command in terminal:

`curl -X POST -F "file=@file-path" "http://localhost:3000/api/file_details/" | ruby prettify_json.rb`

where `file-path` is the full pathname of a plain text file.

To remove all words containing the word "blue", add `no_blues=true` to the query string.

To include a collection of possibly misspelled words, add `spell_check=true` to the query string.

To receive a collection of details of all uploaded files, run the following command in terminal:

`curl -X GET http://localhost:3000/api/file_details | ruby prettify_json.rb`

To run the test suite, run `bundle exec rspec`.
