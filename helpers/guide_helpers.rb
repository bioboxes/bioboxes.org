module GuideHelpers

  class Page
    def initialize(current_page, data)

      url_parts = current_page.url.split("/")

      #get "developer" or "user" out of /guide/developer/create-a-task/
      guide_type = url_parts[2]

      #get /create-a-task/ out of /guide/developer/create-a-task/
      guide_page = "/" + url_parts.pop() + "/"

      #get url prefix /guide/developer out of /guide/developer/create-a-task/
      url_prefix = url_parts.join("/")

      guide = data.guides[guide_type]

      @has_next = false
      @has_previous = false
      @previous_page = ""
      @next_page = ""
      guide.each_with_index do |page, index|
        if page.include? guide_page
          if index == 0
            @previous_page = ""
            @has_previous = false
          else
            @previous_page = url_prefix+guide[index-1][1]
            @has_previous = true
          end
          if index == guide.length-1
            @next_page = ""
            @has_next = false
          else
            @has_next = true
            @next_page = url_prefix+guide[index+1][1]
          end
        end
      end
    end

    def has_previous
      return @has_previous
    end
    def has_next
      return @has_next
    end
    def get_previous
      return @previous_page
    end
    def get_next
      return @next_page
    end
  end
end
