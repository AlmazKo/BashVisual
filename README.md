# Bash::Visual

Bash visualisation tools

## Installation

Add this line to your application's Gemfile:

    gem 'bash-visual'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bash-visual

## Usage

    include Bash_Visual;
    font = Font.new(Font::STD, Font::LIGHT_BLUE)
    console = Console.new(font)
    console.clear()
    console.draw_window(2, 2, 20, 5, 'Example', font, Console::BORDER_UTF_DOUBLE)
    console.write_to_position(5, 3, 'Hello World!', Font.new(Font::BOLD, Font::LIGHT_GREEN))
    console.position = [0, 8]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
