# describes a model that uses the same URL for all subclasses
# this is useful for when all subclasses need to fall under one path
# this assumes the use of the Rails STI convention; please refer to:
# http://api.rubyonrails.org/classes/ActiveRecord/Inheritance.html
module STISingular
  extend ActiveSupport::Concern

  class_methods do
    def inherited(base)
      super
      def base.model_name
        superclass.model_name
      end
    end
  end
end
