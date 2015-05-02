class Guide < Middleman::Extension

  def manipulate_resource_list(resources)
    resources.each do |resource|
      if is_guide? resource
        resource.raw_data.merge! guide_metadata(resource)
      end
    end
  end

  def guide_metadata(resource)
    metadata = {'type' => :guide}

    guides = resource.app.data.guides

    path = resource.destination_path.gsub('index.html', '').gsub(/guide\/(developer|user)/, '')
    guide_name, guide_set = guides.detect{|_, v| v.map(&:last).include? path}
    guide_paths = guide_set.map(&:last)
    index = guide_paths.index(path)

    if index - 1 >= 0
      metadata[:prev] = "/guide/#{guide_name}#{guide_paths[index - 1]}"
    end

    if index + 1 < guide_set.length
      metadata[:next] = "/guide/#{guide_name}#{guide_paths[index + 1]}"
    end

    metadata[:home] = "/guide/#{guide_name}/"

    metadata
  end

  def is_guide?(resource)
    resource.source_file =~ /\/guide\/(developer|user)\//
  end
end

::Middleman::Extensions.register(:guide, Guide)
