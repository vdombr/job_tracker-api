module Services
  module Shared
    module Steps
      class Paginate < Rivulet::Step
        DEFAULT_PAGE  = 1
        DEFAULT_LIMIT = 25

        def call(input)
          paginate_attrs = input.dig(:attributes, :paginate)

          page  = paginate_attrs&.[](:page) || DEFAULT_PAGE
          limit = paginate_attrs&.[](:limit) || DEFAULT_LIMIT

          # TODO: Extension does not work globally
          paginated_resource = input[:resource].extension(:pagination).paginate(page, limit)

          meta = input[:meta] || {}
          meta.merge!(paginate: build_pagination_meta_info(paginated_resource))

          Success(input.merge(resource: paginated_resource, meta: meta))
        end

        private

        def build_pagination_meta_info(resource)
          {
            page: resource.current_page,
            limit: resource.page_size,
            prev_page: resource.prev_page,
            next_page: resource.next_page,
            total_pages: resource.page_count,
            total_records: resource.pagination_record_count
          }
        end
      end
    end
  end
end
