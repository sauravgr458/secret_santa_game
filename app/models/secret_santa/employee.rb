# frozen_string_literal: true

module SecretSanta
  class Employee
    attr_reader :name, :email

    def initialize(name:, email:)
      @name = name.strip
      @email = email.strip.downcase
    end

    def ==(other)
      email == other.email
    end

    def hash
      email.hash
    end

    def eql?(other)
      self == other
    end
  end
end
