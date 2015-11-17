require 'test_helper'

module Sprite
  class SamplesControllerTest < ActionController::TestCase
    setup do
      @sample = sprite_samples(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:samples)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create sample" do
      assert_difference('Sample.count') do
        post :create, sample: { text: @sample.text, title: @sample.title }
      end

      assert_redirected_to sample_path(assigns(:sample))
    end

    test "should show sample" do
      get :show, id: @sample
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @sample
      assert_response :success
    end

    test "should update sample" do
      patch :update, id: @sample, sample: { text: @sample.text, title: @sample.title }
      assert_redirected_to sample_path(assigns(:sample))
    end

    test "should destroy sample" do
      assert_difference('Sample.count', -1) do
        delete :destroy, id: @sample
      end

      assert_redirected_to samples_path
    end
  end
end
