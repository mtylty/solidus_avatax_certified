# frozen_string_literal: true

module SolidusAvataxCertified
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/solidus_avatax_certified\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/solidus_avatax_certified\n"
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=solidus_avatax_certified'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask('Would you like to run the migrations now? [Y/n]'))
        if run_migrations
          run 'bin/rails db:migrate'
        else
          puts 'Skipping bin/rails db:migrate, don\'t forget to run it!' # rubocop:disable Rails/Output
        end
      end

      def include_seed_data
        append_file "db/seeds.rb", <<~SEEDS
                  \n
          SolidusAvataxCertified::Engine.load_seed if defined?(SolidusAvataxCertified::Engine)
        SEEDS
      end
    end
  end
end
