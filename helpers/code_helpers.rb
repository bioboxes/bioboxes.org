require "open-uri"

module CodeHelpers

  GITHUB = 'https://raw.githubusercontent.com/'

  def github_code(repo, file, language)
    url  = File.join(GITHUB, repo, "master", file)
    code = URI.parse(url).read
    ["~~~ #{language}", code, "~~~"].join("\n")
  end

end
