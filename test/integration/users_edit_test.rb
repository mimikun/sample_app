require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                              email: "foo@invalid",
                              password: "foo",
                              password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select "div.alert", "The form contains 4 errors."
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name: name,
                              email: email,
                              password: "",
                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
    # 演習
    # https://railstutorial.jp/chapters/updating_and_deleting_users?version=5.1#sec-exercises_friendly_forwarding
    # 1. フレンドリーフォワーディングで、
    # 渡されたURLに初回のみ転送されていることを、
    # テストを書いて確認してみましょう。
    # 次回以降のログインのときには、
    # 転送先のURLはデフォルト (プロフィール画面)
    # に戻っている必要があります。
    # ヒント: リスト 10.29のsession[:forwarding_url]が
    # 正しい値かどうか確認するテストを追加してみましょう。
  end
end
