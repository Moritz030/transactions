require 'pg'
require 'active_record'
require_relative './app/models/example_record'
require_relative './app/services/some_nice_service_with_transaction'
require_relative './app/services/some_nice_service_with_transaction_and_requires_new'

ActiveRecord::Base.establish_connection(
      adapter:  "postgresql",
      url: 'postgresql://postgres@postgres:5432'
)

# making sure the table is empty
ExampleRecord.delete_all
puts "Table is empty: #{ExampleRecord.count} records"
puts "\n\n"

puts "Start Example 1:"
ActiveRecord::Base.transaction do
      SomeNiceServiceWithTransaction.new.call

      # i am expecting that the service might raise
      # so i am rescuing the exception here
      rescue => e
            puts "Rescued: #{e}"
      
      # now i am creating another record
      ExampleRecord.create!(attribute_1: 'example from main')
end

puts "following output is 2! because the outer transaction 'hijacks' the inner transaction:"
puts "#{ExampleRecord.count} records" 
puts "#{ExampleRecord.first.attribute_1} is one of two records in the table"
puts "#{ExampleRecord.last.attribute_1} is the other record in the table"
puts "\n\n"


# making sure the table is empty again
ExampleRecord.delete_all
puts "Table is empty again: #{ExampleRecord.count} records"
puts "\n\n"

puts "Start Example 2"
ActiveRecord::Base.transaction do
      SomeNiceServiceWithTransactionAndRequiresNew.new.call

      # i am expecting that the service might raise
      # so i am rescuing the exception here
      rescue => e
            puts "Rescued: #{e}"
      
      # now i am creating another record
      ExampleRecord.create!(attribute_1: 'example from main')
end

puts "following output is 1! because the outer transaction does not 'hijack' the inner transaction:"
puts "#{ExampleRecord.count} records"
puts "#{ExampleRecord.first.attribute_1} is the only record in the table"
puts "\n"
