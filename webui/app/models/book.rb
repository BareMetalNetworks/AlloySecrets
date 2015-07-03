class Book
  include Mongoid::Document
  include Redis::Search

  field :title, type: String
  field :author, type: String
  field :info, type: String
  field :version, type: String
  field :metadata, type: String
  field :count, type: Integer
  field :timestamp, type: Time
  field :pages, type: Array
  field :hits, type: Integer
  #field :category
  ## Bad bad relations ## How about field :category no?
  # Lets play with fire and try a relation or whatever is going on here with category
  belongs_to :user
  belongs_to :category

  redis_search_index(:title_field => title,
                     :author_field => :author,
                     :condition_fields => [:category_id, :user_id],
                     :ext_fields => [:category_name])

  def category_name
    self.category.name
  end

end

class User
  include Mongoid::Document
  include Redis::Search

  field :username
  field :password
  field :fullname
  field :email
  field :signature
  field :books_uploaded
  field :followers_count

  redis_search_index(:title_field => :username,
                     :alias_field => :alias_names,
                     :prefer_index_enable => true,
                     :popularity_field => :followers_count,
                     :ext_fields => [:email, :signature])

end
