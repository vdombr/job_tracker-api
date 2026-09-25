require 'pry'

module Services
  module JobApps
    module Steps
      class BuildStats < Rivulet::Step
        def call(input)
          data = input[:resource]
                 .select(:current_stage, Sequel.function(:COUNT, '*').as(:row_count))
                 .where(user_id: input[:current_user])
                 .group(:current_stage)
                 .map { { _1[:current_stage] => _1[:row_count] } }
                 .reduce({}, &:merge)

          data = JobApp::STAGES.to_h do |stage|
            [stage, data[stage] || 0]
          end

          data[:total] = data.values.sum

          Success(data: data, meta: {})
        end
      end
    end
  end
end
