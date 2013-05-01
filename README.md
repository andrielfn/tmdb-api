# The Movie Database API v3

Ruby wrapper for the The Movie Database API.

This wrapper uses the last version of TMDb API.

More info about the API you can see here: [http://docs.themoviedb.apiary.io/](http://docs.themoviedb.apiary.io).

## Installation

Add this line to your application's Gemfile:

    gem 'tmdb-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tmdb

## Usage

### Find a movie by ID
You can find a movie by your ID from The Movie Database.

```ruby
TMDB::Movie.find(24)
# => #<TMDb::Movie:0x007f99 @id=24, @title="Kill Bill: Vol. 1", @imdb_id="tt0266697" ... >

TMDB::Movie.find(603, language: 'pt')
# => #<TMDb::Movie:0x007f99 @id=603, @title="The Matrix", @imdb_id="tt0133093" ... >
```

### Find a movie by name
Also, you can find movies by matching your name.

```ruby
TMDb::Movie.search('Forrest')
# => [#<TMDb::Movie:0x007f92 @id=13, @title="Forrest Gump", ...>,
#     #<TMDb::Movie:0x007f93 @id=711, @title="Finding Forrester", ...>,
#     #<TMDb::Movie:0x007f94 ... >, ...]

TMDb::Movie.search('wall e', year: 2003)
# => [#<TMDb::Movie:0x007f92 @id=10681, @original_title="WALL·E", ...>]
```
You can filter the serch with the following options: _page_, _language_,
_include_adult_, and _year_.

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
