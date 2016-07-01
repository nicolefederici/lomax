# Lomax
This gem uses the Alan Lomax Archive of Michigan Songs, a collection of field recordings of folk music sung by regular people, to display the songs they collected on their Michigan trip. Through this gem, the user can compare the songs in this archive to the complete AllMusic collection of the known recorded music throughout history, in order to discover which of the Lomax recordings were never otherwise recorded. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lomax'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lomax

## Usage

1. The user types bin/run_lomax to get the gem running in the command line. This displays a welcome and list of Michigan cities.

2. The user chooses from a list of cities, in order to return the Lomax field recordings made there.
  These items are displayed with: title, location, date, artists, and archivists.

3. The user chooses either:
    a. a song to investigate further at AllMusic, in order to return all known recordings in the history of recorded music, in chronological order.
    or 
    b. to leave the current list of songs and go back to the original list of cities to start again.

4. If the user chooses a., they will be taken to a new list of the AllMusic records for that song. Each item will list the     title, date, recording artist(s), composer(s), album title, and label in chronological order.

5. After viewing this new list, the user will be asked to choose between:
    a. seeing the Lomax recordings from another city in Michigan, which takes the user back to the original list.
    or
    b. leaving the program

6. If the user chooses to leave, she is asked if she wants to see all the songs from the Lomax Michigan Archive for which there are no other known recordings in history. 

7. If the user chooses yes, the gem returns a list of these songs and their identifying information from the catalogue.

8. The program says goodbye.



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nicolefederici/lomax. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

