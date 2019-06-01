module GOVUKDesignSystemFormBuilder
  module Inputs
    def govuk_text_field(attribute_name, field_type: 'text', label: {}, hint: {}, width: 'full')
      govuk_generic_text_field(
        attribute_name,
        field_type: field_type,
        label: label,
        hint: hint,
        width: width
      )
    end

    def govuk_tel_field(attribute_name, field_type: 'tel', label: {}, hint: {}, width: 'full')
      govuk_generic_text_field(
        attribute_name,
        field_type: field_type,
        label: label,
        hint: hint,
        width: width
      )
    end

    def govuk_email_field(attribute_name, field_type: 'email', label: {}, hint: {}, width: 'full')
      govuk_generic_text_field(
        attribute_name,
        field_type: field_type,
        label: label,
        hint: hint,
        width: width
      )
    end

    def govuk_url_field(attribute_name, field_type: 'url', label: {}, hint: {}, width: 'full')
      govuk_generic_text_field(
        attribute_name,
        field_type: field_type,
        label: label,
        hint: hint,
        width: width
      )
    end

    def govuk_number_field(attribute_name, field_type: 'number', label: {}, hint: {}, width: 'full')
      govuk_generic_text_field(
        attribute_name,
        field_type: field_type,
        label: label,
        hint: hint,
        width: width
      )
    end

    def govuk_collection_select(attribute_name, collection, value_method, text_method, **args, &block)
      options = { label: {} }.merge(args)
      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join([
          Elements::Label.new(self, object_name, attribute_name, options[:label]).html,

          content_tag(:select, class: 'govuk-select') do
            safe_join(collection.map { |i| tag.option(i.send(text_method), value: i.send(value_method)) })
          end
        ])
      end
    end

  private

    def govuk_generic_text_field(attribute_name, field_type:, label: nil, hint: nil, width:)
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint)
      label_element = Elements::Label.new(self, object_name, attribute_name, label)
      error_element = Elements::ErrorMessage.new(self, object_name, attribute_name)

      input_element = Elements::Input.new(
        self,
        object_name,
        attribute_name,
        aria_described_by: [hint_element.hint_id, error_element.error_id].compact.join(' '),
        field_type: field_type
      )

      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join([label_element, hint_element, error_element, input_element].map(&:html))
      end
    end
  end
end