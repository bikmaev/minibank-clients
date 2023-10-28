class Client < ApplicationRecord
  has_secure_password

  #validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  #validates :login, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "Разрешены только латинские символы" }

end