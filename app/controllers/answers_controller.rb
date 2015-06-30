class AnswersController < ApplicationController
  def create
    @question = Question.find answers_params[:question_id]
    @answer = Answer.new(answers_params)
    @answer.user = current_user
    @answer.question = @question
    @answer.date = Time.now
    @answer.save
    respond_to  do |format|
      if request.xhr?
        format.js {  }
      else
        format.html { redirect_to field_question_path(field_id: Field.find(@question.field_id).name, id: @question.url)  }
      end
    end
  end

  private
  def answers_params
    params.require(:answer).permit(:content, :question_id)
  end
end
