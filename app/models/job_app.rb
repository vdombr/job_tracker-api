class JobApp < Sequel::Model
  STAGES = %w[applied interviewing offer ghosted rejected].freeze
  INIT_STAGE = 'applied'.freeze
end
