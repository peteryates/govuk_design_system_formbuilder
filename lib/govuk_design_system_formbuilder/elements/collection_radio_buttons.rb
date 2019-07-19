module GOVUKDesignSystemFormBuilder
  module Elements
    class CollectionRadioButtons < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, collection, value_method, text_method, hint_method, hint_text:, legend:, inline:, small:, &block)
        super(builder, object_name, attribute_name)

        @collection    = collection
        @value_method  = value_method
        @text_method   = text_method
        @hint_method   = hint_method
        @inline        = inline
        @small         = small
        @legend        = legend
        @hint_text     = hint_text
        @block_content = @builder.capture { block.call } if block_given?
      end

      def html
        hint_element  = Elements::Hint.new(@builder, @object_name, @attribute_name, @hint_text)
        error_element = Elements::ErrorMessage.new(@builder, @object_name, @attribute_name)

        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          Containers::Fieldset.new(@builder, legend: @legend, described_by: [error_element.error_id, hint_element.hint_id]).html do
            @builder.safe_join(
              [
                hint_element.html,
                error_element.html,
                @block_content,
                Containers::Radios.new(@builder, inline: @inline, small: @small).html do
                  @builder.safe_join(build_collection)
                end
              ].compact
            )
          end
        end
      end

    private

      def build_collection
        @collection.map do |item|
          Elements::Radios::CollectionRadioButton.new(
            @builder,
            @object_name,
            @attribute_name,
            item,
            @value_method,
            @text_method,
            @hint_method
          ).html
        end
      end
    end
  end
end