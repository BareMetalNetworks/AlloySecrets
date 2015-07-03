class Book
  include Mongoid::Document
  field :title, type: String
  field :author, type: String
  field :info, type: String
  field :version, type: String
  field :metadata, type: String
  field :count, type: Integer
  field :timestamp, type: Time
  field :pages, type: Array
end
