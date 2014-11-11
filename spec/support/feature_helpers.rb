def with_scope(locator)
  locator ? within(locator) { yield } : yield
end

module Features
  module AuthenticationHelpers
    unless ActionController::Base.new.respond_to?(:authenticate_user!)
      ActionController::Base.class_eval do
        define_method(:authenticate_user!) { true }
      end
    end
  end
end
