# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Response.destroy_all
AnswerChoice.destroy_all 
Question.destroy_all 
Poll.destroy_all 
User.destroy_all 

100.times do
  User.create(username: Faker::Internet.unique.username)
end

user_ids = User.pluck(:id)
300.times do 
  Poll.create(
    title: Faker::Book.title,
    author_id: user_ids.sample
  )
end

poll_ids = Poll.pluck(:id)
900.times do 
    Question.create(
      poll_id: poll_ids.sample,
      text: Faker::Lorem.question
    )
end

question_ids = Question.pluck(:id)
3600.times do 
    AnswerChoice.create(
      text: Faker::Lorem.sentence,
      question_id: question_ids.sample
    )
end

responder_ids = User.pluck(:id)
answer_choice_ids = AnswerChoice.pluck(:id)
10000.times do 
    Response.create(
      responder_id: responder_ids.sample,
      answer_choice_id: answer_choice_ids.sample
    )
end