# == Schema Information
#
# Table name: notes
#
#  id           :integer          not null, primary key
#  note         :string(255)
#  note_type_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
