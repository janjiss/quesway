# encoding: utf-8
module SurveysHelper
  def published?(survey)
    if survey.published == true
      return{:class => "published", :title => "Published"}
    else
      return{:class => "unpublished", :title => "Not published"}
    end
  end
end
