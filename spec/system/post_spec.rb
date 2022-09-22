# frozen_string_literal: true

require "rails_helper"

describe "投稿のテスト" do
  describe "トップ画面(root_path)のテスト" do
    before do
      visit root_path
    end
    context "表示の確認" do
      it "トップ画面(root_path)に「新着投稿一覧」が表示されているか" do
        expect(page).to have_content "新着投稿一覧"
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq("/")
      end
    end
  end

  describe "投稿画面(new_post_path)のテスト" do
    before do
      @post = FactoryBot.build(:post)
      @user = FactoryBot.create(:user)
      sign_in @user
      visit new_post_path
    end
    context "表示の確認" do
      it 'new_post_pathが"/posts/new"であるか' do
        expect(current_path).to eq("/posts/new")
      end
      it "投稿ボタンが表示されているか" do
        expect(page).to have_button "投稿"
      end
    end
    context "投稿処理のテスト"  do
      it "投稿後のリダイレクト先は正しいか", js: true do
        find("#total-form").find("img[alt='5']").click
        find("#story-form").find("img[alt='5']").click
        find("#fear-form").find("img[alt='5']").click
        find("#splatter-form").find("img[alt='5']").click
        fill_in "post[review]", with: @post.review
        page.execute_script %!$('[name="post[category]"]').val("#{@post.category}")!
        page.execute_script %!$('[name="post[tmdb_no]"]').val("#{@post.tmdb_no}")!
        click_button "投稿する"
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end

  describe "詳細画面のテスト" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }

    before do
      sign_in user
      visit post_path(post)
    end
    context "表示の確認" do
      it "削除リンクが存在しているか" do
        expect(page).to have_link "削除"
      end
      it "編集リンクが存在しているか" do
        expect(page).to have_link "編集"
      end
    end
    context "リンクの遷移先の確認" do
      it "編集の遷移先は編集画面か" do
        edit_link = find_all("a")[5]
        edit_link.click
        expect(current_path).to eq("/posts/" + post.id.to_s + "/edit")
      end
    end
    context "投稿削除のテスト" do
      it "postの削除" do
        expect do
          edit_link = find_all("a")[6]
          edit_link.click
        end.to change { Post.count }.by(-1)
      end
    end
  end
end
