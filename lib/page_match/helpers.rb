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
        m.see %(a flash error containing "#{error}")
        m.page { within("#flash_error") { has_content?(error) } }
      end
    end

    def have_form_error(error)
      PageMatch.match do |m|
        m.have %(a form error that contains "#{error}")
        m.page { within(".error_messages") { has_content?(error) } }
      end
    end

  end
end
