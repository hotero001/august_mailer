require 'nokogiri'
require 'httparty'

#page = HTTParty.get('https://www.realclearpolitics.com/epolls/other/president_trump_job_approval-6179.html')
#parsed = Nokogiri::HTML(page)
#parsed.css('tr.rcpAvg').to_s

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @user = User.new
    @users = User.all
    @my_user = User.first
    @page = HTTParty.get('https://www.realclearpolitics.com/epolls/other/president_trump_job_approval-6179.html')
    @parsed = Nokogiri::HTML(@page)
    @string_form = @parsed.css('tr.rcpAvg').to_s
    a = "sample"
    b = "spread"
    @substring_of_string = @string_form[/#{a}(.*?)#{b}/m, 1]
    x = "<td>"
    y = "</td>"
    @approval_rate = @substring_of_string[/#{x}(.*?)#{y}/m, 1].to_f
    #@parsed.css('tr.rcpAvg').to_s
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        #used this line of code below to trigger email
        ExampleMailer.sample_email(@user).deliver

        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
