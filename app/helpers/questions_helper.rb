module QuestionsHelper
  counter = 0
  def check_duplicate_url(url)
    if Question.find_by(url: url)
      places = (Math::log counter).to_int
      url[url.size - places] = counter
      @new_url = check_duplicate_url (url)
    else
      url
    end
  end
end
