# frozen_string_literal: true

# Client - класс модели клеинта  (клиент банка)
class Client < ApplicationRecord
  validates :full_name, presence: true
  # validates :login, presence: true, uniqueness: true, on: :create
  # validates :email, presence: true, uniqueness: true, on: :create
  validates :login, presence: true, on: :create
  validates :email, presence: true, on: :create
  validates :password, presence: true, length: { minimum: 6 }
  validates :login, presence: true, on: :update
  validates :email, presence: true, on: :update

  has_secure_password
  # помнить, что при update обязательно задавать так же и пароль

  # validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # validates :login, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "Разрешены только латинские символы" }
end
