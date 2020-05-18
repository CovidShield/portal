module ApplicationHelper
  def nav_item(path, &block)
    if request.path == path
      content_tag(:span, class: 'popover__link popover__link--active', &block)
    else
      link_to(path, class: 'popover__link', role: 'menuitem', &block)
    end
  end

  def text_field_classes(errors)
    classnames = ['text-field']

    if errors.any?
      classnames.push('text-field--error')
    end

    classnames.join(' ')
  end
end
