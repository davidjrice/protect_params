module ActionController
  module Macros
    module ProtectParams #:nodoc:
      def self.included(base) #:nodoc:
        base.extend(ClassMethods)
      end
      # Example:
      #
      #   # Controller
      #   class ApplicationController < ActionController
      #     protect_params_for :post, :user
      #   end
      #   
      module ClassMethods
        def protect_params_for(*models)
          before_filter :protect_params
          models.flatten! # accept an array too
          define_method "protect_params" do
            params.each do |k,v|
              if models.include? k.to_sym # matching model found block params
                safe_params = params[k].block(k.to_s.classify.constantize.protected_params)
                params.update({k => safe_params})
              end
            end
          end
        end
      end
    end
  end
end
module ActiveRecord
  module ActsMethods
    module ProtectedParams #:nodoc:
      def self.included(base) #:nodoc:
        base.extend(ClassMethods)
      end
      # Example:
      #
      #   # Model
      #   class User < ActiveRecord::Base
      #     attr_param_protected :id, :created_at
      #   end
      #   
      module ClassMethods
        @attr_protected_params = nil
        
        def attr_param_protected(*attrs) 
          @attr_protected_params = attrs.flatten.collect {|a| a.to_s }
        end # Rails stores params in a '' accessed hash
        
        def protected_params
          @attr_protected_params
        end
      end
    end
  end
end