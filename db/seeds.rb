# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

create_user = false
create_categories = false
create_articles = false

if create_user
  User.create!(first_name: "John", last_name: "Doe", email: "a@a.com", password: "123456")
end

if create_categories
  ["ONEZERO", "CULTURE", "TECH", "STARTUPS", "SELF", "POLITICS", "HEALTH", "DESIGN", "HUMAN PARTS", "COLLECTIONS"].each do |cat|
    Category.create!(name: cat.capitalize)
  end
end


if create_articles
  user = User.last
  category = Category.last

  400.times do |art|
    Article.create!(user: user,
                    category: category,
                    title: "Article #{art} Lorem ipsum 1231231231231231231 test oasidjasiodjasoid", 
                    is_draft: false,
                    body: "Ipsum quis natus ducimus modi quasi fuga? Quos distinctio doloremque molestias nam sit. Id corporis harum facere minima excepturi distinctio amet Quod itaque officiis a qui laudantium, repellendus Debitis voluptate explicabo rem minus recusandae. Quas consequatur ut quae quia quis hic Distinctio facere officiis debitis repellendus beatae Quis ab suscipit fugiat asperiores pariatur alias adipisci Dolor ab ratione dignissimos dignissimos obcaecati Dicta eaque id provident amet maiores perferendis Exercitationem vitae commodi itaque facilis officia Reiciendis fuga mollitia assumenda quis repellendus, velit magnam Nobis laborum fugiat ipsa unde obcaecati? Voluptate laudantium id at illum nemo, magni neque placeat officiis. Tempora tempora autem voluptatem quos molestias Numquam sit aliquam praesentium molestiae doloribus. Accusamus aut ea id dicta nemo quod Velit earum officiis voluptatum impedit nulla At magni dolorum nulla quod aliquam Vitae non dolore iste eos necessitatibus. Optio tempora ullam quis aliquid architecto, quam Magni alias aut non quia animi earum Provident eveniet modi blanditiis modi debitis. Magni delectus unde pariatur vero possimus ad. Aliquid laboriosam illum quae corrupti praesentium Fuga est provident iste suscipit quisquam culpa Rerum suscipit cumque consequatur tempora nihil Illo optio sit molestiae laborum optio. Impedit ipsam ipsam rem asperiores dignissimos sequi Laborum repellat pariatur alias id earum in similique nemo, repellendus voluptatum! Suscipit quod reiciendis nobis nesciunt molestias necessitatibus Quas in assumenda recusandae reprehenderit debitis nobis Quis commodi fugit officiis error omnis eos recusandae Voluptatum vero minus perferendis distinctio animi Labore aut quae sequi harum omnis! Voluptates quibusdam earum vero reprehenderit similique Libero sunt vitae tempora et itaque. Quibusdam qui unde deserunt maxime esse quia corrupti tenetur Tempore veritatis molestias voluptatum molestias magnam Odio error dolorum laudantium omnis cum reprehenderit Fugit facilis impedit nulla esse porro eveniet. Possimus ipsam quaerat dolore dolores mollitia, temporibus autem Nemo aperiam ducimus autem neque commodi ut. Ut itaque accusantium nemo tempora")
  end
end
