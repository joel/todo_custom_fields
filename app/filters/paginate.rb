# frozen_string_literal: true

module Paginate
  def paginate(resources)
    limit = params[:per_page] ||= 10
    page  = params[:page] ||= 1

    resources = params.key?(:page) ? resources.limit(limit).offset(limit * (page - 1)) : resources

    block_given? ? yield(resources) : resources
  end
end
