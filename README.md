# page_match

RSpec 2 matcher class for building custom Capybara matchers for use in acceptance-level tests.

## Install

page_match is distributed as a Ruby gem:

    sudo gem install page_match

## Using page_match

With the rise in popularity of RSpec + Capybara as an acceptance (aka. request-level) test replacement for Cucumber, using custom matchers can go a long way to clean up your examples, as well as improve your test readability.

Consider the following HTML, which is rendered as the home page of a standard Rack-based web app:

``` html
<html>
  <head><title>Home Page</title></head>
  <body>
    <div id="#logout-link">
      <a href="/logout">Logout Joe User</a>
    </div>
    <h1 id="#main-header">Welcome Joe User</h1>
  </body>
</html>
```

One fairly common acceptance test would be to verify the text rendered for the logout link and the main header to make sure they include the correct user's name. In vanilla RSpec that might look like this:

```ruby
describe "Visiting the home page", :type => :request do
  before(:each) do
    @user = User.login(:name => "Joe User")
  end

  context "The home page" do
    before(:each) do
      visit(root_path)
    end

    it "should have the correct logout link" do
      within("#logout-link") do
        page.should have_content("Logout #{@user.name}")
      end
    end

    it "should have the correct main header" do
      within("#main-header") do
        page.should have_content("Welcome #{@user.name}")
      end
    end
  end
end
```

Running these examples with the _--format documentation_ option turned on, gives us:

```
Visiting the home page
  The home page
    should have the correct logout link
    should have the correct main header
```

On the surface, this example code and the documentation output is just fine. However the code is both hard to refactor and extremely verbose, with the HTML structure traversal code directly in the examples. In addition, the output lines that describe the examples are very generic.

Using **page_match** we can create helper methods that wrap the matcher logic for our examples, gives us  methods that we can reuse and lets us construct much better example descriptions:

```ruby
module MatchHelpers
  def have_logout_link_for(name)
    PageMatch.match do |pm|
      pm.have %(a logout link for "#{name}")
      pm.page { within ("#logout-link") { has_content?("Logout #{name}") } }
    end
  end

  def have_main_header_for(name)
    PageMatch.match do |pm|
      pm.have %(a main header for "#{name}")
      pm.page { within ("#main-header") { has_content?("Welcome #{name}") } }
    end
  end
end
```

With these helper methods in place, we can now rewrite the acceptance test:

``` ruby
describe "Visiting the home page", :type => :request do
  before(:each) do
    @user = User.login(:name => "Joe User")
  end

  subject { page }

  context "The home page" do
    before(:each) do
      visit(root_path)
    end

    it { should have_logout_link_for(@user.name) }
    it { should have_main_header_for(@user.name) }
  end
end
```

When we run this example file, with the _--format documentation_ option, we get:

```
Visiting the home page
  The home page
    should have a logout link for "Joe User"
    should have a main header for "Joe User"
```

The resulting test file is now easier to read, contains examples that make use of custom, domain specific matchers, that when output provide us with context-specific descriptions for those examples.
