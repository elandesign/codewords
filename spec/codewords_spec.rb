require_relative "spec_helper"

describe Codewords do
  it "launches the React app" do
    get '/'

    expect(page).to have_selector("div#codewords")
    expect(page).to have_selector("script[src=\"/javascripts/codewords.js\"]", visible: false)
  end
end
