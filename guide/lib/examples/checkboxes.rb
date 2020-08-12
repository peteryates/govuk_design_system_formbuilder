module Examples
  module Checkboxes
    def checkbox_field
      <<~SNIPPET
        = f.govuk_collection_check_boxes :department_ids,
          departments,
          :id,
          :name,
          legend: { text: "Which department do you work in?" }
      SNIPPET
    end

    def checkbox_field_with_hints
      <<~SNIPPET
        = f.govuk_collection_check_boxes :lunch_ids,
          lunch_options,
          :id,
          :name,
          :description,
          legend: { text: "What is your preferred lunch option?" }
      SNIPPET
    end

    def small_checkboxes
      <<~SNIPPET
        = f.govuk_collection_check_boxes :wednesday_lunch_ids,
          lunch_options,
          :id,
          :name,
          :description,
          small: true,
          legend: { text: "What would you like for lunch on Wednesday?" }
      SNIPPET
    end

    def checkbox_field_with_custom_options
      <<~SNIPPET
        = f.govuk_check_boxes_fieldset :languages, legend: { text: "Which languages do you speak?", size: "m" } do

          = f.govuk_check_box :languages,
            :english,
            label: { text: "English" },
            link_errors: true,
            hint: { text: "Only select English if you have a GCSE at grade C or above" }

          = f.govuk_check_box :languages,
            :welsh,
            label: { text: "Welsh" }

          = f.govuk_check_box :languages,
            :gaelic,
            label: { text: "Gaelic" }

          = f.govuk_check_box :languages,
            :other,
            label: { text: "Other" } do

            = f.govuk_text_field :other_language,
              label: { text: "Which additional language do you speak?" }
      SNIPPET
    end

    def single_checkbox
      <<~SNIPPET

        = f.govuk_check_boxes_fieldset :terms_and_conditions_agreed,
          legend: { text: 'Terms and conditions', size: 'l' } do

          = f.hidden_field :terms_and_conditions_agreed, value: false

          p.govuk-body
            | Our terms and conditions contain important information about:

          ul.govuk-list.govuk-list--bullet
            li the application process
            li contacting us
            li our use of your data
            li checking you're safe to work with children

          = f.govuk_check_box :terms_and_conditions_agreed,
            true,
            multiple: false,
            link_errors: true,
            label: { text: 'I agree to the terms and conditions' }
      SNIPPET
    end
  end
end
