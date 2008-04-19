# Include hook code here
require 'protect_params'
require 'hash_extension'
ActionController::Base.class_eval do
  include ActionController::Macros::ProtectParams
end
ActiveRecord::Base.class_eval do
  include ActiveRecord::ActsMethods::ProtectedParams
end