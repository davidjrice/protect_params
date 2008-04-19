require File.expand_path(File.join(File.dirname(__FILE__), '../../../../test/test_helper'))
require 'protect_params'
ActionController::Base.class_eval do
  include ActionController::Macros::ProtectParams
end

ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
end

class Post
  class_eval { include(ActiveRecord::ActsMethods::ProtectedParams) }
  attr_accessor :id, :title, :type
  attr_param_protected :id, :type
end

class PostController < ActionController::Base
  protect_params_for :post
  
  def create
    @perams = params # intentional mis-spelling :)
  end
end

class ProtectParamsTest < Test::Unit::TestCase
  # Replace this with your real tests.
  
  def setup
    @controller = PostController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_should_block_params
    post :create, :post => {:id => 1, :title => "Something"}
    assert assigns(:perams).has_key?('post')
    assert !assigns(:perams)['post'].has_key?('id')
  end
  
  def test_should_block_multiple_params
    post :create, :post => {:id => 1, :title => "Something", :type => "Widget"}
    assert !assigns(:perams)['post'].has_key?('id')
    assert !assigns(:perams)['post'].has_key?('type')
  end
    
end
