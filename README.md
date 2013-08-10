# The Movie Database API

[![Build Status](https://travis-ci.org/andrielfn/tmdb-api.png)](https://travis-ci.org/andrielfn/tmdb-api)

A simple Ruby wrapper for the The Movie Database API v3.

About the TMDb API documentation and everything else you can se here: [http://docs.themoviedb.apiary.io/](http://docs.themoviedb.apiary.io).

## Installation

Add this line to your application's Gemfile:

    gem 'tmdb-api'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install tmdb


## API Key
First of all, you need set your API Key provided by TMDb.

```ruby
TMDb.api_key = '56565958363476674e5e63643c787867'
```

## Usage

### Find a movie by id
Get the basic movie information for a specific movie id.

```ruby
TMDB::Movie.find(24)
# => #<TMDb::Movie:0x007f99 @id=24, @title="Kill Bill: Vol. 1", @imdb_id="tt0266697" ... >

TMDB::Movie.find(603, language: 'pt')
# => #<TMDb::Movie:0x007f99 @id=603, @title="The Matrix", @imdb_id="tt0133093" ... >
```

Available attributes: `id`, `adult`, `backdrop_path`, `belongs_to_collection`,
`budget`, `genres`, `homepage`, `imdb_id`, `original_title`, `overview`,
`popularity`, `poster_path`, `production_companies`, `runtime`,
`production_countries`, `release_date`, `revenue`, `spoken_languages`, `status`,
 `tagline`, `title`, `vote_average`, `vote_count`.

### Search movies
Search for movies by title.

```ruby
TMDb::Movie.search('Forrest')
# => [#<TMDb::Movie:0x007f92 @id=13, @title="Forrest Gump", ...>,
#     #<TMDb::Movie:0x007f93 @id=711, @title="Finding Forrester", ...>,
#     #<TMDb::Movie:0x007f94 ... >, ...]

TMDb::Movie.search('wall e', year: 2003)
# => [#<TMDb::Movie:0x007f92 @id=10681, @original_title="WALL·E", ...>]
```
You also have another options that you can use to filter the search: `:page`,
`:language`, `:include_adult` and `:year`.

### Alternative titles
Get the alternative titles for a specific movie id.

```ruby
TMDB::Movie.alternative_titles(598)
# => [{"iso_3166_1"=>"RU", "title"=>"Город бога"},
# {"iso_3166_1"=>"IT", "title"=>"City of God - La città di Dio"},
# {"iso_3166_1"=>"BR", "title"=>"Cidade de Deus"},
# {"iso_3166_1"=>"FR", "title"=>"La cité de Dieu"},
# {"iso_3166_1"=>"DE", "title"=>"City of God"},
# {"iso_3166_1"=>"CN", "title"=>"上帝之城"},
# {"iso_3166_1"=>"HK", "title"=>"无主之城"},
# {"iso_3166_1"=>"US", "title"=>"City of God"},
# {"iso_3166_1"=>"TW", "title"=>"無法無天"}]

movie.alternative_titles(country: 'br')
# => [{"iso_3166_1"=>"BR", "title"=>"Cidade de Deus"}]
```

### Images
Get the images (posters and backdrops) for a specific movie id.

```ruby
TMDb::Movie.images(598)
# => {"id"=>598,
#     "backdrops"=> [
#       {
#         "file_path"=>"/hSaH9tt67bozo9K50sbH0s4YjEc.jpg",
#         "width"=>1532,
#         "height"=>862,
#         "iso_639_1"=>nil,
#         "aspect_ratio"=>1.78,
#        "vote_average"=>5.4421768707483,
#         "vote_count"=>7
#       },
#       {
#         "file_path"=>"/k4BAPrE5WkNLvpsPsiMfu8W4Zyi.jpg",
#         "width"=>1920,
#         "height"=>1080,
#         "iso_639_1"=>nil,
#         "aspect_ratio"=>1.78,
#         "vote_average"=>5.399159663865546,
#         "vote_count"=>5
#       },
#       {
#         ...
#       }
#     ]}

TMDb::Movie.images(598, language: 'pt')
```

### Movie keywords

Get the plot keywords for a specific movie id.

```ruby
TMDb::Movie.keywords(68721)
# => [
#      {"id"=>2651, "name"=>"nanotechnology"},
#      {"id"=>9715, "name"=>"superhero"},
#      {"id"=>180547, "name"=>"marvel cinematic universe"},
#      {"id"=>156792, "name"=>"3d"},
#      {"id"=>156395, "name"=>"imax"},
#      {"id"=>179430, "name"=>"aftercreditsstinger"},
#      {"id"=>10836, "name"=>"third part"}
#    ]
```

### Movie releases

Get the release date by country for a specific movie id.

```ruby
TMDb::Movie.releases(68721)
# => [
#      {"iso_3166_1"=>"US", "certification"=>"PG-13", "release_date"=>"2013-05-03"},
#      {"iso_3166_1"=>"DE", "certification"=>"12", "release_date"=>"2013-04-30"},
#      {"iso_3166_1"=>"FR", "certification"=>"", "release_date"=>"2013-04-24"},
#      {"iso_3166_1"=>"BG", "certification"=>"C", "release_date"=>"2013-04-26"},
#      {"iso_3166_1"=>"NL", "certification"=>"", "release_date"=>"2013-04-24"},
#      {"iso_3166_1"=>"NO", "certification"=>"", "release_date"=>"2013-04-26"},
#      ...,
#    ]
```

### Upcoming movies

Get the list of upcoming movies. This list refreshes every day.
The maximum number of items this list will include is 100.

```ruby
TMDb::Movie.upcoming
# => [
#      #<TMDb::Movie:0x007fefa4202a10
#       @adult=false,
#       @backdrop_path="/rwibG3yurWQvpjut54nbeiSGhVt.jpg",
#       @id=157375,
#       @original_title="The Lifeguard",
#       @popularity=8.708121262,
#       @poster_path="/xoX6C3mLynwSNRij2tyDT5eVmoc.jpg",
#       @release_date="2013-08-30",
#       @title="The Lifeguard",
#       @vote_average=5.5,
#       @vote_count=3>
#    ]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
