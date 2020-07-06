# frozen_string_literal: true

class Price
  class << self
    def from_cents(cents)
      format '$%#.2f', to_dollars(cents)
    end

    def to_dollars(cents)
      cents / 100.0
    end
  end
end
