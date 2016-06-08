# frozen_string_literal: true
module ThinkFeelDoDashboard
  # Ensure font awesome icon helpers are available.
  module ApplicationHelper
    TOP_LEVEL_CONTROLLERS = %w( arms groups participants users reports ).freeze

    # Render navigational information in the form of breadcrumbs
    def breadcrumbs
      return unless show_breadcrumbs?

      content_for(
        :breadcrumbs,
        content_tag(:ol, class: "breadcrumb") do
          concat(content_tag(:li, link_to("Home", root_path)))

          if can_view_resource_index?
            concat(
              content_tag(
                :li, controller_link
              )
            )
          end
        end
      )
    end

    def social_features?
      if Rails.application.config.respond_to?(:include_social_features)
        Rails.application.config.include_social_features
      end
    end

    private

    def show_breadcrumbs?
      TOP_LEVEL_CONTROLLERS.include?(controller_name)
    end

    def can_view_resource_index?
      begin
        klass = controller_name.singularize.capitalize.constantize
      rescue NameError
        klass = nil
      end

      !klass.is_a?(Class) || can?(:index, klass)
    end

    def controller_link
      link_to(controller_name.capitalize, url_for(controller: controller_name))
    end
  end
end
