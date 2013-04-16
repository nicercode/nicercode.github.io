# Title: Image tag with caption for Jekyll
# Description: Easily output images with captions

# http://blog.zerosharp.com/image-captions-for-octopress/

module Jekyll

  class CaptionImageTag < Liquid::Tag
    @img = nil
    @title = nil
    @class = ''
    @width = ''
    @height = ''

    def initialize(tag_name, markup, tokens)
      if markup =~ /(\S.*\s+)?(https?:\/\/|\/)(\S+)(\s+\d+\s+\d+)?(\s+.+)?/i
        @class = $1 || ''
        @img = $2 + $3
        if $5
          @title = $5.strip
        end
        if $4 =~ /\s*(\d+)\s+(\d+)/
          @width = $1
          @height = $2
        end
      end
      super
    end

    def render(context)
      output = super
      if @img
        "<span class='#{('caption-wrapper ' + @class).rstrip}'>" +
          "<img class='caption' src='#{@img}' width='#{@width}' height='#{@height}' alt='#{@title}' title='#{@title}'>" +
          "<span class='caption-text'>#{@title}</span>" +
        "</span>"
      else
        'Error processing input, expected syntax: <img class="[class name(s)]" src="/url/to/image" title="[width height] [title text]" >'
      end
    end
  end
end

Liquid::Template.register_tag('imgcap', Jekyll::CaptionImageTag)
