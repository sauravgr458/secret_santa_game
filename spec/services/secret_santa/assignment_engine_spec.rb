require 'rails_helper'

RSpec.describe SecretSanta::AssignmentEngine do
  let(:employees) do
    [
      SecretSanta::Employee.new(name: 'Alice', email: 'alice@example.com'),
      SecretSanta::Employee.new(name: 'Bob', email: 'bob@example.com'),
      SecretSanta::Employee.new(name: 'Carol', email: 'carol@example.com')
    ]
  end

  it 'generates valid assignments without self or duplicate assignment' do
    engine = described_class.new(employees)
    result = engine.generate_assignments

    expect(result.keys).to match_array(employees)
    result.each do |giver, receiver|
      expect(giver).not_to eq(receiver)
    end
  end

  it 'avoids previous year assignments' do
    previous = {
      'alice@example.com' => 'bob@example.com'
    }

    engine = described_class.new(employees, previous)
    result = engine.generate_assignments

    expect(result[employees[0]].email).not_to eq('bob@example.com')
  end
end
