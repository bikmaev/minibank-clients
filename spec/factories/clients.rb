# frozen_string_literal: true

# clients/spec/factories/clients.rb
FactoryBot.define do
  factory :client do
    full_name { "Петров Иван Васильевич" }
    login { "petrov_" }
    email { "petr@host.com" }
    password { "password" }
  end
end
