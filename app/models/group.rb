class Group < ActiveRecord::Base
  #association
  has_many :users
end
