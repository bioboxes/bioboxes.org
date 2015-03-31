module ImageHelpers

  def logo(file)
    url = "https://s3-us-west-1.amazonaws.com/bioboxes-images/logo/"
    File.join(url, data.site.logo_version, file)
  end

end
