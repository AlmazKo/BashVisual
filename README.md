# Bash-Visual

Bash visualisation library

## Description
**BashVisual** simplifies Unix-console operation (sh, bash, csh etc). It uses _tput_ and standard Unix-terminal facilities. It is also thread-safe.

BashVisual allows:
- control position, colors and text's form
- draw graphical primitives (rectangle, window)
- create dynamic scrolling objects
- get window parameters (weight, height)

[See the wiki!](https://github.com/AlmazKo/BashVisual/wiki)

## Installation

Add this line to your application's Gemfile:

    gem 'bash-visual'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bash-visual

## Usage
```ruby
require 'bash-visual'
include Bash_Visual

console = Console.new
console.clear

console.draw_window([3, 3], [18, 5], 'Example') {{font: Font.new(:std, :red)}}
console.write_to_position 5, 4, 'Hello World!', Font.new(:bold)
console.position = [0, 8]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
