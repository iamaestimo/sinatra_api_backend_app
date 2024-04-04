require 'faker'

1065.times do
    created_post = Post.create(
        title: Faker::Game.title,
        body: Faker::Quote.famous_last_words
        )

    p "Created #{created_post.title}"
end