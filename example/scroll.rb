$:.push File.expand_path('../../lib', __FILE__)
require 'bash-visual'
include Bash_Visual

Console.new.clear


scroll = VerticalScroll.new(
  coordinates: [1, 1],
  window_size: [20, 5]
)

10.times do
  scroll.add Time.now.strftime('%H-%M-%S:%3N')
  sleep 0.2
end
Time.now.strftime('%H-%M-%S:%3N')