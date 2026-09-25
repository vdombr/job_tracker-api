module Services
  module JobApps
    module Projections
      class Common < Rivulet::Projection
        define! do
          accept_keys(%i[
            id company position url hr_contact
            commentary current_stage applied_at
          ])
        end
      end
    end
  end
end
