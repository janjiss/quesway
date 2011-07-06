# encoding: utf-8
module SurveysHelper
  def published?(survey)
    if survey.published == true
      return{:class => "published", :title => "Publicēta"}
    else
      return{:class => "unpublished", :title => "Nav publicēta"}
    end
  end
end
