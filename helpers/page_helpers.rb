require "open-uri"
require 'yaml'

VALUES = [
  {avail: lambda{|i| ! i[:homepage].nil? },
   text:  ["Homepage", "No homepage available"],
   url:   lambda{|i| i[:homepage] }},

  {avail: lambda{|i| ! i[:image][:source].nil? },
   text:  ["Source Code Repository", "No source code repository available"],
   url:   lambda{|i| i[:image][:source] }},

  {avail: lambda{|i| ! i[:mailing_list].nil? },
   text:  ["Mailing List", "No mailing list available"],
   url:   lambda{|i| i[:mailing_list] }},
]

module PageHelpers
  def biobox_values(biobox)
    VALUES.map do |v|
      avail = v[:avail].call(biobox)
      if avail
        [avail, v[:url].call(biobox), v[:text].first]
      else
        [avail, nil, v[:text].last]
      end
    end
  end

  def biobox_yaml(url)
      data = URI.parse(url).read
      YAML.load(data)
  end

  def dockerhub_url(biobox)
    "https://registry.hub.docker.com/u/" + biobox[:image][:dockerhub]
  end

  def pubmed_url(biobox)
    "https://www.ncbi.nlm.nih.gov/pubmed/" + biobox[:pmid].to_s
  end

  def biobox_id(docker_string)
    chars = %w|_ /|
    chars.inject(docker_string){|s, char| s.gsub(char, '-')}
  end

  def link_to_biobox(docker_string)
    "/bioboxes#" + bioboxes_id(docker_string)
  end
end