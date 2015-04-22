class PageTitle < Middleman::Extension

  def initialize(app, options_hash={}, &block)
    require 'titleize'
    super
  end

  def manipulate_resource_list(resources)
    resources.each do |resource|
      if is_index? resource
        resource.raw_data['page_title'] = "Bioboxes"
      elsif is_markdown? resource
        resource.raw_data['title'] = fetch_title(resource.source_file)
        resource.raw_data['page_title'] = "Bioboxes — " + resource.raw_data['title']

        resource.raw_data['summary'] = fetch_first_paragraph(resource.source_file)
      end
    end
  end

  def fetch_title(path)
    line = File.readlines(path).detect{|i| i =~ /^# /}
    raise ArgumentError, "No title set for #{path}" if line.nil?
    line.gsub("# ", "").titleize
  end

  def fetch_first_paragraph(path)
    File.read(path).split("\n\n")[1]
  end

  def is_index?(resource)
    resource.source_file =~ /index\.mkd/
  end

  def is_markdown?(resource)
    resource.source_file =~ /\.mkd/
  end

end

::Middleman::Extensions.register(:page_title, PageTitle)
