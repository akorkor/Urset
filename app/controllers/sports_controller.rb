class SportsController < ApplicationController
  before_action :set_sport, only: [:show, :edit, :update, :destroy]
  include HTTParty

  # GET /sports
  # GET /sports.json
  def home
    puts "\n******* home *******"
    if current_user
      @sport = Sport.where(user_id: current_user).first
      if @sport.blank?
        puts "\n******* blank *******"
        @sport = Sport.create(user_id: current_user.id)
        puts "\n@sport:#{@sport.inspect}"
      end
    end
  end

  def sports
    puts "\n******* sports *******"
    puts "\nparams:#{params.inspect}"
    @response = HTTParty.get('https://api.sportradar.us/soccer-t3/eu/en/teams/sr:competitor:48/profile.json?api_key=45j87hu8gk42eq8v87yvca8r')
    # puts "\n@response:#{@response.inspect}"

    @sport = Sport.where(user_id: current_user).first
    puts "\n@sport:#{@sport.inspect}"

    @sportBtn = @sport.soccer

  end

  def toggle_sport
    puts "\n******* toggle_sport *******"
    puts "\nparams:#{params.inspect}"

    @sport = Sport.find(current_user.id)
    puts "\n@sport:#{@sport.inspect}"
    puts "\n@sport[params[:sport]]: #{@sport[params[:sport]].inspect}"
    @column = params[:sport].to_sym
    if @sport[params[:sport]] == false
      @sport[params[:sport]] = Sport.update(@sport[:id], @column => true)
    else
      @sport[params[:sport]] = Sport.update(@sport[:id], @column => false)
    end
    @sport = Sport.find(current_user.id)
    puts "\n@sport:#{@sport.inspect}"
    render json: { sport_select: @sport[params[:sport]].to_json }
  end

  # GET /sports
  # GET /sports.json
  def index
    puts "\n******* index *******"
    @sports = Sport.all
  end

  # GET /sports/1
  # GET /sports/1.json
  def show
    puts "\n******* show *******"
  end

  # GET /sports/new
  def new
    puts "\n******* new *******"
    @sport = Sport.new
  end

  # GET /sports/1/edit
  def edit
    puts "\n******* edit *******"
  end

  # POST /sports
  # POST /sports.json
  def create
    puts "\n******* create *******"
    @sport = Sport.new(sport_params)

    respond_to do |format|
      if @sport.save
        format.html { redirect_to @sport, notice: 'Sport was successfully created.' }
        format.json { render :show, status: :created, location: @sport }
      else
        format.html { render :new }
        format.json { render json: @sport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sports/1
  # PATCH/PUT /sports/1.json
  def update
    puts "\n******* update *******"
    respond_to do |format|
      if @sport.update(sport_params)
        format.html { redirect_to @sport, notice: 'Sport was successfully updated.' }
        format.json { render :show, status: :ok, location: @sport }
      else
        format.html { render :edit }
        format.json { render json: @sport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sports/1
  # DELETE /sports/1.json
  def destroy
    puts "\n******* destroy *******"
    @sport.destroy
    respond_to do |format|
      format.html { redirect_to sports_url, notice: 'Sport was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sport
      puts "\n******* set_sport *******"
      @sport = Sport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sport_params
      puts "\n******* sport_params *******"
      params.require(:sport).permit(:user_id, :soccer, :basketball, :baseball, :football, :tennis, :golf, :volleyball, :rugby, :hockey, :nascar)
    end
end
