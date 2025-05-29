# frozen_string_literal: true

namespace :secret_santa do
  desc "Run Secret Santa assignment"
  task assign: :environment do
    require 'csv'
    include SecretSanta

    employee_file = 'data/employee_list.csv'
    last_year_file = 'data/secret_santa_2023.csv'
    output_file = 'data/secret_santa_result_2024.csv'

    employees = CSV.read(employee_file, headers: true).map do |row|
      Employee.new(name: row['Employee_Name'], email: row['Employee_EmailID'])
    end

    previous = {}
    if File.exist?(last_year_file)
      CSV.read(last_year_file, headers: true).each do |row|
        previous[row['Employee_EmailID'].strip.downcase] = row['Secret_Child_EmailID'].strip.downcase
      end
    end

    engine = AssignmentEngine.new(employees, previous)
    assignments = engine.generate_assignments

    CSV.open(output_file, 'wb') do |csv|
      csv << ['Employee_Name', 'Employee_EmailID', 'Secret_Child_Name', 'Secret_Child_EmailID']
      assignments.each do |giver, receiver|
        csv << [giver.name, giver.email, receiver.name, receiver.email]
      end
    end

    puts "🎅 Secret Santa assignments saved to #{output_file}"
  end
end
