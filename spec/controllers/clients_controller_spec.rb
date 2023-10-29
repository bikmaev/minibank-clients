# clients/spec/controllers/clients_controller_spec.rb
require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new client' do
        expect {
          post :create, params: { client: FactoryBot.attributes_for(:client) }
        }.to change(Client, :count).by(1)
      end

      it 'renders a JSON response with the new client' do
        post :create, params: { client: FactoryBot.attributes_for(:client) }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new client' do
        post :create, params: { client: { full_name: '', login: 'petrov3', email: 'pepe@nn.mm', password: 'password' } }
        Rails.logger.info("Инвалидные данные : #{@response.inspect}")
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'GET #index' do
    it 'returns a success response' do
      client = FactoryBot.create(:client, full_name: 'Петров Иван Васильевич2', login: 'petrov4', email: 'petr4@host.com', password: 'password4')
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      client = FactoryBot.create(:client, full_name: 'Петров Иван Васильевич5', login: 'petrov5', email: 'petr5@host.com', password: 'password5')
      get :show, params: { id: client.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { full_name: 'Новое Имя6', password: 'password' }
      }

      it 'updates the client' do
        client = FactoryBot.create(:client, full_name: 'Петров Иван Васильевич6', login: 'petrov6', email: 'petr6@host.com', password: 'password6')
        Rails.logger.info("клиент для теста обновления : #{client.inspect}")
        patch :update, params: { id: client.to_param, client: new_attributes }
        Rails.logger.info("сделали Апдейт : #{client.to_param}")
        client.reload
        Rails.logger.info("после клиент релод : #{client.full_name}")
        expect(client.full_name).to eq('Новое Имя6')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested client' do
      client = FactoryBot.create(:client, full_name: 'Петров Иван Васильевич7', login: 'petrov7', email: 'petr7@host.com', password: 'password7')
      expect {
        delete :destroy, params: { id: client.to_param }
      }.to change(Client, :count).by(-1)
    end
  end
end
