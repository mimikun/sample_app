require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    # 演習
    # https://railstutorial.jp/chapters/updating_and_deleting_users?version=5.1#sec-exercises_user_index
    # レイアウトにあるすべてのリンクに対して
    # 統合テストを書いてみましょう。
    # ログイン済みユーザーとそうでないユーザーの
    # それぞれに対して、正しい振る舞いを考えてください。
    # ヒント: log_in_asヘルパーを使って
    # リスト 5.32にテストを追加してみましょう。
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
  end
end
