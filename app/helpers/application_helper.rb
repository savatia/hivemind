module ApplicationHelper
  @@counter = 0
  def check_duplicate_url(url, model)
    if !model.find_by(url: url).nil?
      @@counter = @@counter.to_i + 1
      if @@counter != 0
        places = (Math.log10 @@counter).to_int
      end

      if !@@counter.nil?
        #url[(-1)..(-places+1)] = @@counter.to_s
        url[-1..-(places+1)] = @@counter.to_s;
      end
      @new_url = check_duplicate_url(url, model)
    else
      url
    end
  end
end
