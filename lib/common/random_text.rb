$:.unshift(File.dirname(__FILE__))
class RandomText
  @@text = File.open(File.dirname(__FILE__)+'/text') { |file| file.read }
  class << self
    def get
      aText = @@text.split(' ')
      len = Random.new.rand(1...30)
      max = Random.new.rand(0...aText.size-len)
      aText[max, len].join(' ')
    end
  end
end
