# Genius API Song Fetcher

This is a small Ruby application that utilizes the Genius API to retrieve a list of songs by a given artist. It takes the name of an artist as input and outputs a list of all the songs by that artist.

Things you may want to cover:

* Ruby 3.1.3

* Setup
    * Install Ruby 3.1.3 using RVM
    * Configure database.yml
    * Run 
      ```bash
      bundle install
      ```
    * Run
      ```bash
      rails db:create
      ```
    * Start the server
      ```bash
      rails s
      ```
    * Add the Genius API access_token in .env
  
## Application Start
* The APP will be accessible at http://localhost:3000
* Enter name of the artist to view its songs


## TODO
* Pagination
