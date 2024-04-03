posts = [
    {title: 'Post #1', body: 'This is post 1'},
    {title: 'Post #2', body: 'This is post 2'},
    {title: 'Post #3', body: 'This is post 3'},
    {title: 'Post #4', body: 'This is post 4'},
    {title: 'Post #5', body: 'This is post 5'},
    {title: 'Post #6', body: 'This is post 6'},
    {title: 'Post #7', body: 'This is post 7'},
    {title: 'Post #8', body: 'This is post 8'},
    {title: 'Post #9', body: 'This is post 9'},
    {title: 'Post #10', body: 'This is post 10'}
]

posts.each do |post|
    created_post = Post.create(title: post[:title], body: post[:body])
    p "Created #{created_post.title}"
end