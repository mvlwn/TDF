class ScoresController < ApplicationController

  load_and_authorize_resource

  before_filter :set_stage
  before_filter :set_score, only: [:edit, :update, :destroy]

  def index
    scores = @stage.scores.order('category', 'points DESC')
    @scores = ScoreDecorator.decorate_collection(scores)
  end

  def new
    quantity = params[:quantity].to_i > 0 ? params[:quantity].to_i : 1
    @scores = [Score.new(stage_id: @stage.id, category: params[:category].to_i)] * quantity
  end

  def create
    if @stage.update_attributes(stage_params)
      StagePointsCalculator.calculate!(@stage)
      flash[:notice] = 'Punten opgeslagen'
      redirect_to stage_scores_path(@stage)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @score.update_attributes(score_params)
      StagePointsCalculator.calculate!(@stage)
      flash[:notice] = 'Punten opgeslagen'
      redirect_to stage_scores_path(@stage)
    else
      render :edit
    end
  end

  def bulk_edit

  end

  def bulk_update
    if @stage.update_attributes(stage_params)
      StagePointsCalculator.calculate!(@stage)
      flash[:notice] = 'Punten opgeslagen'
      redirect_to stage_scores_path(@stage)
    else
      render :bulk_edit
    end
  end

  def destroy
    @score.destroy
    StagePointsCalculator.calculate!(@stage)
    redirect_to stage_scores_path(@stage)
  end

  private

  def stage_params
    params.require(:stage).permit(scores_attributes: [:id, :number, :points, :category])
  end

  def score_params
    params[:score][:stage_id] = params[:stage_id]
    params.require(:score).permit(:number, :category, :points, :stage_id)
  end

  def set_stage
    @stage = Stage.find(params[:stage_id]).decorate
  end

  def set_score
    @score = @stage.scores.find(params[:id])
  end


end
