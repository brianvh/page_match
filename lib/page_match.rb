require "page_match/page"

module PageMatch
  def self.match &block
    PageMatch::Page.match block
  end
end
