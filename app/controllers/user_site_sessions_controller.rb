# controller
class UserSiteSessionsController < ApplicationController
  # handles actions for CRUD actions for Lap Time records.
  before_action :set_user_site_session, only: %i(show edit update destroy)
  before_action :check_logged_in

  # GET /user_site_sessions
  # GET /user_site_sessions.json
  def index
    load_query
  end

  # GET /user_site_sessions/1
  # GET /user_site_sessions/1.json
  def show; end

  # GET /user_site_sessions/new
  def new
    @user_site_session = UserSiteSession.new
    @user = if can? :manage, 'User'
              User.all
            else
              current_user
            end
  end

  # GET /user_site_sessions/1/edit
  def edit; end

  # POST /user_site_sessions
  # POST /user_site_sessions.json
  def create
    before_create
    respond_to do |format|
      if @user_site_session.save
        format.html { redirect_to @user_site_session, notice: 'User site session was successfully created.' }
        format.json { render :show, status: :created, location: @user_site_session }
      else
        format.html { render :new }
        format.json { render json: @user_site_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_site_sessions/1
  # PATCH/PUT /user_site_sessions/1.json
  def update
    respond_to do |format|
      if @user_site_session.update(user_site_session_params)
        format.html { redirect_to @user_site_session, notice: 'User site session was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_site_session }
      else
        format.html { render :edit }
        format.json { render json: @user_site_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_site_sessions/1
  # DELETE /user_site_sessions/1.json
  def destroy
    @user_site_session.destroy
    respond_to do |format|
      format.html { redirect_to user_site_sessions_url, notice: 'User site session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user_site_session
      if current_user.user?
        @user_site_session = UserSiteSession.select('user_site_sessions.*, users.name as user_name, sites.name as venue_name').joins(:user, :site).find(params[:id])
        redirect_to '/user_site_sessions' if @user_site_session.user_id != current_user.id
      end
      @user_site_session = UserSiteSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_site_session_params
      params.require(:user_site_session).permit(:lap_time, :weather, :session_date, :site_id, :user_id)
    end

    def check_logged_in
      redirect_to '/' unless current_user
    end

  private

    def before_create
      @user_site_session = UserSiteSession.new(user_site_session_params)
      @user_site_session.user_id = current_user.id if current_user && current_user.user?
    end

  private

    def load_query
      if current_user.admin?
        @user_site_sessions = if params.key?('showAll')
                                UserSiteSession.select(
                                  'user_site_sessions.*, users.name as user_name, sites.name as venue_name'
                                ).joins(:user, :site).all_quickest
                              else
                                UserSiteSession.select(
                                  'user_site_sessions.*, users.name as user_name, sites.name as venue_name'
                                ).joins(:user, :site).find_by_me
                              end
      elsif current_user.user?
        @user_site_sessions = UserSiteSession.select(
          'user_site_sessions.*, users.name as user_name, sites.name as venue_name'
        ).joins(:user, :site).find_by_me
      else
        redirect_to '/'
      end
    end
end
