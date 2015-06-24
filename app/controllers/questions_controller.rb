class QuestionsController < ApplicationController
  def new
    @quetion = Question.new
    @fields = Field.all
  end

  def create
    @question = Question.new(question_params)
    @question.url = check_duplicate_url @question.title.split(" ").join("_")[0..30]

    @question.user_id = current_user.id
    @field = Field.find(params[:field])
    @question.field_id = @field.id
    @question.save
    redirect_to field_question_path(id:@question.url, field_id: @field.name)
  end

  def show
    @question = Question.find_by(url:params[:id])
  end

  def index

  end

  def destroy

  end

  def edit

  end


  private
  def question_params
    params.require(:question).permit(:title, :content, :field)
  end
end
