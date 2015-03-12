class IndustryController < ApplicationController
  def tree
    result = Industry.where(is_secondary: false, is_deprecated: false).map do |parent|
      {
        label: parent.name,
        id: parent.id,
        children: parent.child_industries.select do |child|
          !child.is_deprecated
        end.map { |child| { id: child.id, label: child.name } }
      }
    end
    render json: result
  end
end
