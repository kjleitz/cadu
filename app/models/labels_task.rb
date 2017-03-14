class LabelsTask < ApplicationRecord
  belongs_to :label, :task
end
