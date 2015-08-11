class QuestionsController < ApplicationController
  before_action :logged_in, except:[ :show, :index]
  def new
    @quetion = Question.new
    @fields = Field.all
  end

  def create
    @question = Question.new(question_params)
    @question.url = check_duplicate_url @question.title.split(" ").join("_")[0..30], Question
    @question.url.remove(".")
    @question.user_id = current_user.id
    @field = Field.find(@question.field_id)

    @question.save
    redirect_to field_question_path(id:@question.url, field_id: @field.name)
  end

  def show
    @question = Question.find_by(url:params[:id])
    @answer = Answer.new
    @answers = Answer.where(:question_id => @question.id)

    if !current_user.nil?

      Notification.where(user_id: current_user.id, desc:"new_answer", seen:nil).each do |n|
        question = Question.find(Answer.find(n.model_id).question_id)
        if question == @question
          n.seen = true
          n.save
        end
      end

      Notification.where(user_id: current_user.id, desc:"best_answer", seen:nil).each do |n|
        question = Question.find(Answer.find(n.model_id).question_id)
        if question == @question
          n.seen = true
          n.save
        end
      end
    end

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
    params.require(:question).permit(:title, :content, :field_id)
  end
end
