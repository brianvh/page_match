module PageMatch
  module Helpers

    def have_link(label)
      PageMatch.match do |m|
        m.have %(a link named "#{label}")
        m.page { has_link?(label) }
      end
    end

    def have_button(label)
      PageMatch.match do |m|
        m.have %(a button named "#{label}")
        m.page { has_button?(label) }
      end
    end

    def have_flash_notice(note)
      PageMatch.match do |m|
        m.have %(a flash notice containing "#{note}")
        m.page { within("#flash_notice") { has_content?(note) } }
      end
    end

    def have_flash_error(error)
      PageMatch.match do |m|
        m.have %(a flash error containing "#{error}")
        m.page { within("#flash_error") { has_content?(error) } }
      end
    end

    def have_form_error(error)
      PageMatch.match do |m|
        m.have %(a form error that contains "#{error}")
        m.page { within(".error_messages") { has_content?(error) } }
      end
    end

    def have_text_field(form, field)
      PageMatch.match do |m|
        m.have %(a text field on the #{form} form for #{field.inspect})
        m.page { has_selector?(:xpath, %(.//input[@id="#{form}_#{field}"][@type="text"])) }
      end
    end

    def have_text_area(form, field)
      PageMatch.match do |m|
        m.have %(a text area on the #{form} form for #{field.inspect})
        m.page { has_selector?(:xpath, %(.//textarea[@id="#{form}_#{field}"])) }
      end
    end

    def have_check_box(form, field)
      PageMatch.match do |m|
        m.have %(a checkbox on the #{form} form for #{field.inspect.gsub(/_$/, '')})
        m.page { has_selector?(:xpath, %(.//input[@id="#{form}_#{field}"][@type="checkbox"])) }
      end
    end

    def have_select_field(form, field)
      PageMatch.match do |m|
        m.have %(a select field on the #{form} form for #{field.inspect})
        m.page { has_selector?(:xpath, %(.//select[@id="#{form}_#{field}"])) }
      end
    end
  end
end
