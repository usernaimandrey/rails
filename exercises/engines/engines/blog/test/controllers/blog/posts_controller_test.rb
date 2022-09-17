# frozen_string_literal: true

require 'test_helper'

module Blog
  class PostsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @post = blog_posts(:one)
    end

    test 'should get index' do
      get posts_url
      assert_response :success
    end

    test 'should get new' do
      get new_post_url
      assert_response :success
    end

    test 'should create post' do
      assert_difference('Post.count') do
        post posts_url, params: { post: { content: @post.content, title: @post.title } }
      end

      assert_redirected_to post_url(Post.last)
    end

    test 'should show post' do
      get post_url(@post)
      assert_response :success
    end

    test 'should get edit' do
      get edit_post_url(@post)
      assert_response :success
    end

    test 'should update post' do
      patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }
      assert_redirected_to post_url(@post)
    end

    test 'should destroy post' do
      assert_difference('Post.count', -1) do
        delete post_url(@post)
      end

      assert_redirected_to posts_url
    end
  end
end
