module Jekyll
  class EndingredientTag < Liquid::Tag
    
  end
end
Liquid::Template.register_tag('endingredient', Jekyll::EndingredientTag)
