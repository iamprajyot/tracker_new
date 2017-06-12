class Employee < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true, length: {minimum: 3, maximum: 20}
  validates :username, format: {with: /\A[a-zA-Z']+\z/, message: 'Username should not contain any spaces, numbers or special characters'}

  scope :active, -> { where(is_deleted: false) }
end
