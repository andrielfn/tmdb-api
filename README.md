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

### Movie object

```ruby
movie = TMDb::Movie.find(27205)

movie.id # => 27205
movie.adult # => false
movie.backdrop_path # => /s2bT29y0ngXxxu2IA8AOzzXTRhd.jpg
movie.belongs_to_collection # => {"id"=>179836, "name"=>"Inception Collection", "poster_path"=>"/7OtEJQjBhxNug5TyY0ny4ttuKdg.jpg", "backdrop_path"=>"/73WuAqGGCv3F8Rwy5FTnYlji6IS.jpg"}
movie.budget # => 160000000
movie.genres # => [{"id"=>28, "name"=>"Action"}, {"id"=>12, "name"=>"Adventure"}, {"id"=>9648, "name"=>"Mystery"}, {"id"=>878, "name"=>"Science Fiction"}, {"id"=>53, "name"=>"Thriller"}]
movie.homepage # => http://inceptionmovie.warnerbros.com/
movie.imdb_id # => tt1375666
movie.original_title # => Inception
movie.overview # => Dom Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: "inception", the implantation of another person's idea into a target's subconscious.
movie.popularity # => 8.908730111185815
movie.poster_path # => /tAXARVreJnWfoANIHASmgYk4SB0.jpg
movie.production_companies # => [{"name"=>"Warner Bros. Pictures", "id"=>174}, {"name"=>"Syncopy", "id"=>9996}]
movie.runtime # => 148
movie.production_countries # => [{"iso_3166_1"=>"US", "name"=>"United States of America"}]
movie.release_date # => 2010-07-16
movie.revenue # => 825532764
movie.spoken_languages # => [{"iso_639_1"=>"en", "name"=>"English"}, {"iso_639_1"=>"ja", "name"=>"日本語"}, {"iso_639_1"=>"fr", "name"=>"Français"}]
movie.status # => Released
movie.tagline # => Your mind is the scene of the crime.
movie.title # => Inception
movie.vote_average # => 8.2
movie.vote_count # => 497
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
