module Jekyll
  class IngredientTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip+".md"
    end
    require "kramdown"
    
    def render(context)
       docs=File.read(File.join(Dir.pwd, 'ingredients', @text))
      "#{Kramdown::Document.new(docs).to_html}"
    end
  end
end
Liquid::Template.register_tag('ingredient', Jekyll::IngredientTag)
