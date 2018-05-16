require 'rails_helper'

include ActionDispatch::TestProcess::FixtureFile

feature "Sale Records Testing", type: :feature do

  before(:all) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  scenario "uploading no file" do
      visit '/'
      expect(page).to have_content("Facebook")
      click_link "Facebook"
      expect(page).to have_content("Here is some info about you...")
      expect(page).to have_content("Jane Doe")  # user name
      expect(page).to have_css("img[src='http://graph.facebook.com/v2.10/1850210715035716/picture']") # user image
      expect(page).to have_content("Log Out")
      visit pages_salerecords_url
      expect(page).to have_content("SalesRecord File Upload!")
      click_button "Upload"
      expect(page).to have_content("A file must be provided!")
  end

  scenario "uploading correct file" do
      visit '/'
      expect(page).to have_content("Facebook")
      click_link "Facebook"
      expect(page).to have_content("Here is some info about you...")
      expect(page).to have_content("Jane Doe")  # user name
      expect(page).to have_css("img[src='http://graph.facebook.com/v2.10/1850210715035716/picture']") # user image
      expect(page).to have_content("Log Out")
      visit pages_salerecords_url
      expect(page).to have_content("SalesRecord File Upload!")
      attach_file("uploadedFile[datafile]", build_upload_file("example_input.tab"), visible: false)
      click_button "Upload"
      expect(page).to have_content("File has been uploaded successfully and total value is: 95.0")
  end

  scenario "uploading correct file" do
      visit '/'
      expect(page).to have_content("Facebook")
      click_link "Facebook"
      expect(page).to have_content("Here is some info about you...")
      expect(page).to have_content("Jane Doe")  # user name
      expect(page).to have_css("img[src='http://graph.facebook.com/v2.10/1850210715035716/picture']") # user image
      expect(page).to have_content("Log Out")
      visit pages_salerecords_url
      expect(page).to have_content("SalesRecord File Upload!")
      attach_file("uploadedFile[datafile]", build_upload_file("example_input_invalid_values.tab"), visible: false)
      click_button "Upload"
      expect(page).to have_content("Failure detected while parsing file with message: Purchase count with invalid value [a] at row [1].")
  end

  scenario "uploading correct file" do
      visit '/'
      expect(page).to have_content("Facebook")
      click_link "Facebook"
      expect(page).to have_content("Here is some info about you...")
      expect(page).to have_content("Jane Doe")  # user name
      expect(page).to have_css("img[src='http://graph.facebook.com/v2.10/1850210715035716/picture']") # user image
      expect(page).to have_content("Log Out")
      visit pages_salerecords_url
      expect(page).to have_content("SalesRecord File Upload!")
      attach_file("uploadedFile[datafile]", build_upload_file("example_input_wrong_number_of_columns.tab"), visible: false)
      click_button "Upload"
      expect(page).to have_content("Failure detected while parsing file with message: Row [1] has wrong number of columns [7].")
  end

  scenario "uploading correct file" do
      visit '/'
      expect(page).to have_content("Facebook")
      click_link "Facebook"
      expect(page).to have_content("Here is some info about you...")
      expect(page).to have_content("Jane Doe")  # user name
      expect(page).to have_css("img[src='http://graph.facebook.com/v2.10/1850210715035716/picture']") # user image
      expect(page).to have_content("Log Out")
      visit pages_salerecords_url
      expect(page).to have_content("SalesRecord File Upload!")
      attach_file("uploadedFile[datafile]", build_upload_file("layout_memory.xml"), visible: false)
      click_button "Upload"
      expect(page).to have_content("Failure detected while parsing file with message: Provided file thrown malformed CSV error with message: Illegal quoting in line 2.")
  end

  scenario "uploading invalid mime type" do
      visit '/'
      expect(page).to have_content("Facebook")
      click_link "Facebook"
      expect(page).to have_content("Here is some info about you...")
      expect(page).to have_content("Jane Doe")  # user name
      expect(page).to have_css("img[src='http://graph.facebook.com/v2.10/1850210715035716/picture']") # user image
      expect(page).to have_content("Log Out")
      visit pages_salerecords_url
      expect(page).to have_content("SalesRecord File Upload!")
      attach_file("uploadedFile[datafile]", build_upload_file("standard.pdf"), visible: false)
      click_button "Upload"
      expect(page).to have_content("Failure detected while parsing file with message: Provided file has invalid mime type [application/pdf].")
  end

end

def build_upload_file( file_name )
  return Rails.root + "test/resources/" + file_name
end

