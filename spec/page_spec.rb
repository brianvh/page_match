require 'rspec'
require 'page_match'

describe "PageMatch module" do
  describe ".match" do
    it "returns an instance of PageMatch::Page" do
      match = PageMatch.match { have 'a Page instance' }
      match.should be_instance_of(PageMatch::Page)
    end
  end
end
