require 'byebug'

module A
class Abi

  attr_reader :core, :context
  MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

end
end

# p A::Abi::MODULE