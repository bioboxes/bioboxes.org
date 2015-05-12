require 'uri'
require 'net/http'

class CustomCodeBlocks < Redcarpet::Render::HTML

  def block_code(code, language)
    url = code.strip
    block_content = ""
    case
      when url =~ /\A#{URI::regexp(['http', 'https'])}\z/
        parsed_url = URI.parse(url)
        req = Net::HTTP::Post.new(parsed_url.request_uri)
        http = Net::HTTP.new(parsed_url.host, parsed_url.port)
        http.use_ssl = true
        res = http.start() { |http|
          http.request(req)
        }
        block_content = res.body
      else
        block_content = code
    end
    create_block_code(block_content, language)
  end

  def create_block_code(code, language)
    "<pre>" \
      "<span class=\"code-block-title\">"+language.upcase+":</span>" \
             "<code>#{html_escape(code)}</code>" \
    "</pre>"
  end

  def html_escape(string)
    string.gsub(/['&\"<>\/]/, {
                                '&' => '&amp;',
                                '<' => '&lt;',
                                '>' => '&gt;',
                                '"' => '&quot;',
                                "'" => '&#x27;',
                                "/" => '&#x2F;',
                            })
  end
end