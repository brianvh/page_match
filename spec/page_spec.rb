require 'rspec'
require 'page_match'

describe "PageMatch module" do
  describe ".match" do
    it "returns an instance of PageMatch::Page" do
      matcher = PageMatch.match { have 'a Page instance' }
      matcher.should be_instance_of(PageMatch::Page)
    end
  end
end

describe PageMatch::Page do
  before(:each) do
    @matcher = PageMatch::Page.new
  end

  it "initializes with a nil message attribute" do
    @matcher.message.should be_nil
  end

  context "#matches? against a page object" do
    before(:each) do
      @page = mock(:page)
    end

    context "for a true match" do
      before(:each) do
        @page.should_receive(:is_true?).once.and_return(true)
        @matcher.page { is_true? }
      end

      it "returns true" do
        @matcher.should be_matches(@page) 
      end
    end

    context "for a false match" do
      before(:each) do
        @page.should_receive(:is_not_true?).once.and_return(false)
        @matcher.page { is_not_true? }
      end

      it "returns false" do
        @matcher.should_not be_matches(@page) 
      end
    end
  end
end