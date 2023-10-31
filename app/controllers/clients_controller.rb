# frozen_string_literal: true

# ClientsController - отвечает за CRUD методы client
class ClientsController < ApplicationController
  before_action :set_client, only: %i[show update destroy]

  # GET /clients
  def index
    @clients = Client.all
    render json: @clients
  end

  # GET /clients/1
  def show
    render json: @client
  end

  # POST /search
  def search
    search_params = client_search_params.except(:password)
    conditions = []
    values = []

    # if search_params[:full_name].present?
    #  conditions << "full_name = ?"
    #  values << search_params[:full_name]
    # end

    # if search_params[:login].present?
    #  conditions << "login = ?"
    #  values << "%#{search_params[:login]}%"
    # end

    # if search_params[:email].present?
    #  conditions << "email = ?"
    #  values << "%#{search_params[:email]}%"
    # end

    search_params.each do |field, value|
      next if value.blank?

      conditions << "#{field} = ?"
      values << "%#{value}%"
    end

    query = conditions.join(" AND ")
    @clients = Client.where(query, *values)

    # Rails.logger.info("поиск where: #{@clients.inspect}")
    # @clients.select { |client| client.authenticate(params[:password]) }
    # Rails.logger.info("отфильтровано по authenticate : #{@clients.inspect}")
    render json: @clients
  end

  def login_check
    if params[:login].present?
      @client = Client.find_by(login: params[:login])
      if @client&.authenticate(params[:password])
        render json: @client, status: :ok
      else
        render json: { message: 'Клиент не найден.' }, status: :not_found
      end
    else
      # Обработка случая, когда параметр login отсутствует или пуст
      render json: { message: 'Ошибка в логине.' }, status: :not_found
    end
  end

  # POST /clients
  def create
    @client = Client.new(client_params)
    @client.password = params[:password] if params[:password].present?
    if @client.save
      render json: @client, status: :created, location: @client
    else
      render json: { error: @client.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  def update
    if unique_attributes?(client_params) && @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
    render json: { message: 'Клиент был успешно удален.' }
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:full_name, :login, :email, :password)
  end

  def client_search_params
    # params.permit(:full_name, :login, :email, :password)
    Rails.logger.info("client_search_params : #{params}")
    params.slice(:full_name, :login, :email, :password).compact
    # search_params = { login: params[:login].presence, email: params[:email].presence, full_name: params[:full_name].presence }
  end

  def unique_attributes?(params)
    login_unique = if params[:login].present? && params[:login] != @client.login
                     Client.where.not(id: @client.id).where(login: params[:login]).empty?
                   else
                     true
                   end

    email_unique = if params[:email].present? && params[:email] != @client.email
                     Client.where.not(id: @client.id).where(email: params[:email]).empty?
                   else
                     true
                   end

    login_unique && email_unique
  end
end
