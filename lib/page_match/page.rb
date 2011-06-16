module PageMatch
  class Page
    attr_reader :description, :message
    attr_accessor :contain, :not_contain, :did, :did_not

    def initialize
      @contain = %(expected the page to contain)
      @not_contain = %(expected the page to not contain)
      @did = %(but it did)
      @did_not = %(but it didn't)
    end

    def self.match(&block)
      page = Page.new
      yield page if block_given?
      page
    end

    def page(&block)
      @page_block = block
    end

    def have(msg='')
      @message = msg
      @description = %(have #{msg})
    end

    def contain(msg='')
      @message = msg
      @description = %(contain #{msg})
    end

    def failure_message
      %(#{contain} #{message}, #{did_not})
    end

    def negative_failure_message
      %(#{not_contain} #{message}, #{did})
    end

    def matches?(page_instance)
      page_instance.instance_eval(&@page_block)
    end
  end
end
