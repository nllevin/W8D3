# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  responder_id     :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ApplicationRecord
  belongs_to :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_choice_id

    belongs_to :respondent,
      class_name: :User,
      primary_key: :id,
      foreign_key: :responder_id
  end
