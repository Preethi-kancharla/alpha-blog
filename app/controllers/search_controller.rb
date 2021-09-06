class SearchController < ApplicationController
    def search
        if params[:category_name].blank?
            redirect_to(root_path, alert: "Empty field!!") and return
        else
            parameter = params[:category_name].downcase
            category = Category.get_category_by_name(parameter)
            if category
                redirect_to("/categories/#{category.id}")
            else
                redirect_to(categories_path, alert: "Sorry! Specified category not found")
            end
        end
    end
end