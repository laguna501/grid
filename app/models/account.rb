class Account < ActiveRecord::Base
  belongs_to :user, inverse_of: :accounts
  has_many :photos
end
