module ThinkFeelDoDashboard
  # Ensure font awesome icon helpers are available.
  module ApplicationHelper
    include FontAwesome::Rails::IconHelper

    TOP_LEVEL_CONTROLLERS = %w( arms groups participants users reports )

    # Render navigational information in the form of breadcrumbs
    def breadcrumbs
      return unless show_breadcrumbs?

      content_for(
        :breadcrumbs,
        content_tag(:ol, class: "breadcrumb") do
          concat(content_tag(:li, link_to("Home", root_path)))

          if can_view_resource_index?
            concat(content_tag(:li,
                               link_to(controller_name.capitalize,
                                       url_for(controller: controller_name))
                              )
                  )
          end
        end
      )
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
  end
end
