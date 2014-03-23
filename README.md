# The Movie Database API

[![Build Status](https://travis-ci.org/andrielfn/tmdb-api.png?branch=master)](https://travis-ci.org/andrielfn/tmdb-api)
[![Code Climate](https://codeclimate.com/github/andrielfn/tmdb-api.png)](https://codeclimate.com/github/andrielfn/tmdb-api)

A simple Ruby wrapper for the The Movie Database API v3.

About the TMDb API documentation and everything else you can se here: [http://docs.themoviedb.apiary.io/](http://docs.themoviedb.apiary.io).

## Installation

Add this line to your application's Gemfile:

    gem 'tmdb-api'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install tmdb-api


## API Key
First of all, you need set your API Key provided by TMDb.

```ruby
TMDb.api_key = '56565958363476674e5e63643c787867'
```

Also it's possible set the API in the `TMDB_API_KEY` environment variable:

```sh
$ export TMDB_API_KEY='56565958363476674e5e63643c787867'
```

## Usage

### Find a movie by id
Get the basic movie information for a specific movie id.

```ruby
TMDB::Movie.find(24)

TMDB::Movie.find(603, language: 'pt')
```

Optional parameters:

- `language` - ISO 639-1 code.

The available attributes are: _id_, _adult_, _backdrop_path_, _belongs_to_collection_,
_budget_, _genres_, _homepage_, _imdb_id_, _original_title_, _overview_,
_popularity_, _poster_path_, _production_companies_, _runtime_,
_production_countries_, _release_date_, _revenue_, _spoken_languages_, _status_,
 _tagline_, _title_, _vote_average_, _vote_count_.


### Search movies
Search for movies by title.

```ruby
TMDb::Movie.search('Forrest')

TMDb::Movie.search('wall e', year: 2003)
```

Optional parameters:

- `page` - Minimum 1, maximum 1000.
- `language` - ISO 639-1 code.
- `include_adult` - Toggle the inclusion of adult titles. Expected value is:
_true_ or _false_.
- `year` - Filter the results release dates to matches that include this value.
- `primary_release_year` - Filter the results so that only the primary release
dates have this value.
- `search_type` - By default, the search type is 'phrase'. This is almost
guaranteed the option you will want. It's a great all purpose search type and by
far the most tuned for every day querying. For those wanting more of an
"autocomplete" type search, set this option to 'ngram'.


### Alternative titles
Get the alternative titles for a specific movie id.

```ruby
TMDB::Movie.alternative_titles(598)

TMDB::Movie.alternative_titles(598, country: 'br')
```

Optional parameters:

- `country` - ISO 3166-1 code.

### Cast
Get the cast for a specific movie id.

```ruby
TMDb::Movie.cast(550)

TMDb::Movie.cast(550, language: 'pt')
```

### Crew
Get the crew for a specific movie id.

```ruby
TMDb::Movie.crew(550)


TMDb::Movie.crew(550, language: 'fr')
```

### Movie images
Get the images (posters and backdrops) for a specific movie id.

```ruby
TMDb::Movie.images(598)

TMDb::Movie.images(598, language: 'pt')
```

### Movie keywords

Get the plot keywords for a specific movie id.

```ruby
TMDb::Movie.keywords(68721)
```

### Movie trailers

Get the trailers for a specific movie id.

```ruby
TMDb::Movie.trailers(68721)
```

### Movie releases

Get the release date by country for a specific movie id.

```ruby
TMDb::Movie.releases(68721)
```

### Upcoming movies

Get the list of upcoming movies. This list refreshes every day.
The maximum number of items this list will include is 100.

```ruby
TMDb::Movie.upcoming
```

### Find a person by id

Get the basic person information for a specific person id.

```ruby
TMDB::Person.find(138)
```

Available attributes: _id_, _name_, _adult_, _also_known_as_, _biography_
_birthday_, _deathday_, _homepage_, _place_of_birth_, _profile_path_,
_popularity_, _imdb_id_.

### Search people
Search for people by name.

```ruby
TMDb::Person.search('Paul')

TMDb::Person.search('Paul', page: 4)
```

Optional parameters:

- `page` - Minimum 1, maximum 1000.
- `include_adult` - Toggle the inclusion of adult titles. Expected value is:
_true_ or _false_.

### Person images

Gets the images for a specific person id.

```ruby
TMDb::Person.images(138)
```

### Popular people

Gets a list of popular people. This list refreshes every day.

```ruby
TMDb::Person.popular
```

Optional parameters:

- `page` - Minimum 1, maximum 1000.

### Changes

##### Movie changes

Get a list of movie ids that have been edited. By default we show the last 24
hours and only 100 items per page. The maximum number of days that can be
returned in a single request is 14.

```ruby
TMDb::Changes.movies

TMDb::Changes.movies(page: 1, start_date: '2013-03-22')
```

Optional parameters:

- `page` - Minimum 1, maximum 1000.
- `start_date` - YYYY-MM-DD.
- `end_date` - YYYY-MM-DD.

## Contributing

1. Fork it.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create new Pull Request.
