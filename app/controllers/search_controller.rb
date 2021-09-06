class SearchController < ApplicationController
    def search
        if params[:category_name]
            category = Category.get_category_by_name(params[:category_name].capitalize)
            if category
                redirect_to("/categories/#{category.id}")
            else
                redirect_to(categories_path, alert: "Sorry! Specified category not found")
            end
        end
    end
end