require "open-uri"

module CodeHelpers

  GITHUB = 'https://raw.githubusercontent.com/'
  MAX_FILE_LENGTH = 100000

  def github_code(repo, file, language, fileStart = 0, fileEnd = MAX_FILE_LENGTH)
    url  = File.join(GITHUB, repo, "master", file)
    codeLines = URI.parse(url).read.lines.to_a
    codeBlock = fileStart < codeLines.length ? codeLines[fileStart .. fileEnd].join('') : ""
    ["~~~ #{language}", codeBlock, "~~~"].join("\n")
  end

end
