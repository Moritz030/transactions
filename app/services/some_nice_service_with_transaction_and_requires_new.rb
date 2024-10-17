class SomeNiceServiceWithTransactionAndRequiresNew
  def call
    ActiveRecord::Base.transaction(requires_new: true) do
      ExampleRecord.create!(attribute_1: 'example from service')
      # i am doing some important stuff here
      # and suddenly the service raises an exception
      raise 'some error'
    end
  end
end