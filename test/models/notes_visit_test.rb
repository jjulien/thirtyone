# == Schema Information
#
# Table name: notes_visits
#
#  id         :integer          not null, primary key
#  note_id    :integer
#  visit_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class NotesVisitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
