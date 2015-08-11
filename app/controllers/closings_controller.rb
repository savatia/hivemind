class ClosingsController < ApplicationController
  before_action :authaurized?
  def new
    session[:return_to] ||= request.referer
    @question = Question.find params[:question_id]
    @closing = Closing.new

    if Closing.find_by(question_id: params[:question_id])
      flash[:message] = "Question has already been closed."
      redirect_to field_question_path(id: @question.url, field_id: Field.find(@question.field_id).name)
    elsif(Moderator.find_by(user: current_user.id)).field_id != @question.field_id
      flash[:message] = "You are not authaurized to do this action."
      redirect_to  field_question_path(id: @question.url, field_id: Field.find(@question.field_id).name)
    end
  end

  def create
    @closing = Closing.new(closing_params)
    @closing.moderator = Moderator.find_by(:user_id => current_user.id)
    @question = Question.find(@closing.question_id)
    if Closing.find_by(question_id: @question.id)
      flash[:message] = "Question has already been closed."
      redirect_to field_question_path(id: @question.url, field_id: Field.find(@question.field_id).name)
    elsif(Moderator.find_by(user: current_user.id)).field_id != @question.field_id
      flash[:message] = "You are not authaurized to do this action."
      redirect_to  field_question_path(id: @question.url, field_id: Field.find(@question.field_id).name)
    elsif @closing.save
      redirect_to field_question_path(id: @question.url, field_id: Field.find(@question.field_id).name)
    else
      flash[:danger] = "Reason required!"
      redirect_to new_closing_path+"?question_id=#{@closing.question_id}"

    end

  end

  private
  def closing_params
    params.require(:closing).permit(:question_id, :reason)
  end

  def authaurized?
    if current_user.nil?
      flash[:danger] = "Not authaurized!"
      redirect_to root_path
      false
    else
      if(Moderator.find_by(user: current_user))
        true
      else
        flash[:danger] = "Not authaurized!"
        redirect_to root_path
        false
      end
    end
  end

end
