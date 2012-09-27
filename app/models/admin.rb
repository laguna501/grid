class Admin < ActiveRecord::Base
  acts_as_authentic

  attr_accessor :original_password
  attr_accessor :override_rules
  attr_accessible :username, :password, :password_confirmation
  
  class OriginalPasswordValidator < ActiveModel::Validator
    def validate(record)
    	return true if record.override_rules
    	return true if record.original_password.blank?
      record.errors.add(:original_password, "is wrong") and return false unless record.valid_password?(record.original_password)
    end
  end

  validates_with OriginalPasswordValidator
end
