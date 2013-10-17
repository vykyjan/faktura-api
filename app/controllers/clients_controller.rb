class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json


  def index

    @clients = current_user.clients
  end

  # GET /clients/1
  # GET /clients/1.json
  def show

    @client = Client.find(params[:id])
  end

  # GET /clients/new
  def new
    @client = Client.new

  end

  # GET /clients/1/edit
  def edit
    @user = User.find(params[:id])

    # For URL like /orders/1/items/2/edit
    # Get item id=2 for order 1
    @client = @user.clients.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = current_user.clients.new(client_params)

    @client.save
    redirect_to @client
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    @user = User.find(params[:id])
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      # Save the item successfully
      redirect_to user_client_url(@user, @client)
    else
      render :action => "edit"
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @user = User.find(params[:user_id])
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to user_clients_path(@user) }
      format.xml  { head :ok }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :register, :ic, :dic, :adress, :bank_account, :hdp, :user_id)
    end
end
