class CheckboxInput < SimpleForm::Inputs::BooleanInput
  def input
    if nested_boolean_style?
      build_hidden_field_for_checkbox +
        template.label_tag(nil, class: classes) {
          build_check_box_without_hidden_field + check_box_replacement + inline_label
        }
    else
      build_check_box
    end
  end

  def check_box_replacement
    template.content_tag(:span, class: 'tick') do
      template.content_tag(:span)
    end
  end

  def classes
    classes = ['checkbox', 'custom']
    classes << 'checked' if checked?
    classes.join(' ')
  end

  def checked?
    object.send(attribute_name).present?
  end
end
