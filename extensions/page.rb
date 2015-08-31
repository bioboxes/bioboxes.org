class Page < Middleman::Extension

  def initialize(app, options_hash={}, &block)
    require 'titleize'
    super
  end

  def manipulate_resource_list(resources)
    resources.each do |resource|
      resource.raw_data.merge! page_metadata(resource)
    end
  end

  def page_metadata(resource)
    if is_index? resource
      {"page_title" => "Bioboxes"}
    elsif is_markdown? resource
      title = fetch_title(resource.source_file)
      {
        'title'            => title,
        'page_title'       => "Bioboxes - " + title,
        'summary'          => fetch_first_paragraph(resource.source_file),
        'is_documentation' => is_documentation?(resource)
      }
    else
      {}
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

  def self.match_resource_url(name, regexp)
    define_method(name) do |resource|
      not resource.source_file.match(regexp).nil?
    end
  end

  match_resource_url :is_index?,         /index\.mkd/
  match_resource_url :is_documentation?, /\/docs\//
  match_resource_url :is_markdown?,      /\.mkd/

end

::Middleman::Extensions.register(:page, Page)
