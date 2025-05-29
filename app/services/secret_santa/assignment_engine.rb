# frozen_string_literal: true

module SecretSanta
  class AssignmentEngine
    def initialize(employees, previous_assignments = {})
      @employees = employees.shuffle
      @previous_assignments = previous_assignments
    end

    def generate_assignments
      assignments = {}
      max_attempts = 100

      max_attempts.times do
        shuffled = @employees.shuffle
        valid = true

        @employees.each_with_index do |giver, i|
          receiver = shuffled[i]
          if invalid_assignment?(giver, receiver, assignments)
            valid = false
            break
          else
            assignments[giver] = receiver
          end
        end

        return assignments if valid

        assignments.clear
      end

      raise "Unable to generate valid assignments after #{max_attempts} attempts"
    end

    private

    def invalid_assignment?(giver, receiver, assignments)
      giver.email == receiver.email ||
        @previous_assignments[giver.email] == receiver.email ||
        assignments.values.include?(receiver)
    end
  end
end
