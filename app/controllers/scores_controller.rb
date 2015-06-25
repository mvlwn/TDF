class ScoresController < ApplicationController

  load_and_authorize_resource

  before_filter :set_stage
  before_filter :set_score, only: [:edit, :update, :destroy]

  def index
    scores = @stage.scores.order('category', 'ranking')
    @scores = ScoreDecorator.decorate_collection(scores)
  end

  def new

  end

  def create
    @score = Score.new(stage: @stage)
    if @score.update_attributes(params[:score])
      flash[:notice] = 'Punten opgeslagen'
      redirect_to stage_scores_path(@stage)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @score.update_attributes(params[:score])
      flash[:notice] = 'Punten opgeslagen'
      redirect_to stage_scores_path(@stage)
    else
      render :edit
    end
  end

  def destroy
    @score.destroy
    redirect_to stage_scores_path(@stage)
  end

  private

  def set_stage
    @stage = Stage.find(params[:stage_id]).decorate
  end

  def set_score
    @score = @stage.scores.find(params[:id])
  end


end
