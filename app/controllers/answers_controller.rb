class AnswersController < ApplicationController
  def create

    @question = Question.find answers_params[:question_id]
    if Closing.find_by(question_id: @question.id)
      flash[:message] = "Question has been closed."
      redirect_to field_question_path(id: @question.url, field_id: Field.find(@question.field_id).name)

    else
      @answer = Answer.new(answers_params)
      @answer.user = current_user
      @answer.question = @question
      @answer.date = Time.now
      @answer.save
      Notification.create!(user_id:@question.user_id, desc:"new_answer", model_id:@answer.id)


      respond_to  do |format|
        if request.xhr?
          format.js {  }
        else
          format.html { redirect_to field_question_path(field_id: Field.find(@question.field_id).name, id: @question.url)  }
        end
      end
    end

  end

  def best
    @answer = Answer.find(params[:answer_id])
    @question = Question.find(@answer.question_id)
    if Closing.find_by(question_id: @question.id)
      flash[:message] = "Question has been closed."
      redirect_to field_question_path(id: @question.url, field_id: Field.find(@question.field_id).name)
    else
      if !Answer.where(best: true, question_id: @question.id).any?
        @answer.best = true
        @answer.save
        Notification.create!(user_id:@answer.user_id, desc:"best_answer", model_id:@answer.id)
      end

      respond_to  do |format|
        if request.xhr?
          format.js { render @question  }
        else
          format.html { redirect_to field_question_path(field_id: Field.find(@question.field_id).name, id: @question.url)  }
        end
      end
    end
  end

  private
  def answers_params
    params.require(:answer).permit(:content, :question_id)
  end
end
