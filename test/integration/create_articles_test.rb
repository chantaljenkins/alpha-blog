require 'test_helper'

class CreateArticles < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  test 'should get articles form and create new article' do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params: {article: {title: "test", description: "This is a test description"}}
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_match "test", response.body
  end

end
