class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]

  # GET /clients
  def index
    @clients = Client.all
    render json: @clients
  end

  # GET /clients/1
  def show
    render json: @client
  end

  # POST /clients
  def create
    Rails.logger.info("Клиент парамс для сохранения: #{client_params}")
    Rails.logger.info("пароль для сохранения: #{params[:password]}")
    @client = Client.new(client_params)
    Rails.logger.info("создан объект клиент: #{@client.inspect}")
    @client.password = params[:password] if params[:password].present?
    Rails.logger.info("Клиент для сохранения: #{@client.inspect}")
    if @client.save
      render json: @client, status: :created, location: @client
    else
      Rails.logger.error("Клиент после сохранения: #{@client.inspect}")
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

  def unique_attributes?(params)
    Rails.logger.info("параметры проверки уникальности : #{params}")
    Rails.logger.info("параметры проверки уникальности : #{@client.inspect}")
    if params[:login].present? && params[:login] != @client.login
      login_unique = Client.where.not(id: @client.id).where(login: params[:login]).empty?
    else
      login_unique = true
    end

    if params[:email].present? && params[:email] != @client.email
      email_unique = Client.where.not(id: @client.id).where(email: params[:email]).empty?
    else
      email_unique = true
    end

    login_unique && email_unique
  end


end