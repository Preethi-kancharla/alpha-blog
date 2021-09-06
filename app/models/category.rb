class Category < ApplicationRecord
    has_many :article_categories
    has_many :articles, through: :article_categories
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
    validates_uniqueness_of :name

    def self.get_category_by_name(name)
        #category = all.where("name Like = ?", name).exists? ? find_by_name(name) : false
        category = all.where("lower(name) LIKE :search", search: "%#{name}%").first
    end

end