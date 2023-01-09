# frozen_string_literal: true

ActiveSupport.on_load(:active_support_test_case) { include FactoryBot::Syntax::Methods }
