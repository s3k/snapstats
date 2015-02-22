module Snapstats
  module ApplicationHelper
  	def active_cat? cat_type
  		raw "class=\"active section-#{cat_type}\"" if  params[:controller].scan(/#{cat_type.to_s}/).present? 
  	end
  end
end
