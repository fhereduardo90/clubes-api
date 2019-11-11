class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable

  enum gender_categories: {
    female: 'female',
    male: 'male',
    other: 'other',
    prefer_not_to_say: 'prefer not to say'
  }

  validates :first_name, :last_name, :username, :gender, presence: true
  validates :username, uniqueness: true
  validates :username, length: { in: 6..12 }
  validates :gender, inclusion: { in: gender_categories.values }

  def full_name
    "#{first_name} #{last_name}"
  end
end
