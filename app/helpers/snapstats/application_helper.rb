module Snapstats
  module ApplicationHelper
  	def active_cat? cat_type
  		raw 'class="active"' if  params[:controller].scan(/#{cat_type.to_s}/).present? 
  	end
  end
end
