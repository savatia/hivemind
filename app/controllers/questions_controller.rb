class QuestionsController < ApplicationController
  before_action :logged_in, except: :show
  def new
    @quetion = Question.new
    @fields = Field.all
  end

  def create
    @question = Question.new(question_params)
    @question.url = check_duplicate_url @question.title.split(" ").join("_")[0..30], Question

    @question.user_id = current_user.id
    @field = Field.find(params[:field])
    @question.field_id = @field.id
    @question.save
    redirect_to field_question_path(id:@question.url, field_id: @field.name)
  end

  def show
    @question = Question.find_by(url:params[:id])
    @answer = Answer.new
    @answers = Answer.where(:question_id => @question.id)
  end

  def index

  end

  def destroy
    @question = Question.find(params[:id])
    if current_user == User.find(@question.user_id)
      @question.destroy
      redirect_to questions_path
    else
      redirect_to field_question_path(id: @question.url, field_id: @question.field_id)
    end
  end

  def edit

  end


  private
  def question_params
    params.require(:question).permit(:title, :content, :field)
  end
end
