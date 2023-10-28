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
    #@client = Client.new(client_params.merge(password: params[:password]))
    Rails.logger.info("создан объект клиент: #{@client.inspect}")
    @client.password = params[:password]
    Rails.logger.info("Клиент для сохранения: #{@client.inspect}")
    if @client.save
      render json: @client, status: :created, location: @client
    else
      #render json: @client.errors, status: :unprocessable_entity
      #Rails.logger.error(@client.errors.full_messages) # вывод ошибок в лог
      Rails.logger.error("Клиент после сохранения: #{@client.inspect}")
      render json: { error: @client.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  #def create
    #begin
    #@client = Client.new(client_params[:client])
    #Rails.logger.info("параметры для сохранения клиента: #{client_params}")
    #if @client.save
    #  render json: @client, status: :created, location: @client
    #else
    #  render json: @client.errors, status: :unprocessable_entity
    #end
    #rescue StandardError => e
    #Rails.logger.error("Ошибка при создании клиента: #{e.message}")
    #Rails.logger.error(e.backtrace.join("\n"))
    #render json: { error: 'Ошибка при создании клиента.' }, status: :internal_server_error
    #end
    #begin
    #  @client = Client.new(client_params)
    #  Rails.logger.info("параметры для сохранения клиента: #{client_params}")
    #  if @client.save
    #    render json: @client, status: :created, location: @client
    #  else
    #    Rails.logger.error(@client.errors.full_messages) # вывод ошибок в лог
    #    render json: @client.errors, status: :unprocessable_entity
    #  end
    #rescue StandardError => e
    #  Rails.logger.error("Ошибка при создании клиента: #{e.message}")
    #  Rails.logger.error(e.backtrace.join("\n"))
    #  render json: { error: 'Ошибка при создании клиента.' }, status: :internal_server_error
    #end
  #end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
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

  #def client_params
  #  params.require(:client).permit(:full_name, :login, :email, :password, :password_confirmation)
  #  Rails.logger.info("client_params cheq requirements: #{params}")
  #end

  def client_params
    params.require(:client).permit(:full_name, :login, :email, :password)
  end
end