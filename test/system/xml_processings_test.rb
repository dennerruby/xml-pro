require "application_system_test_case"

class XmlProcessingsTest < ApplicationSystemTestCase
  setup do
    @xml_processing = xml_processings(:one)
  end

  test "visiting the index" do
    visit xml_processings_url
    assert_selector "h1", text: "Xml processings"
  end

  test "should create xml processing" do
    visit xml_processings_url
    click_on "New xml processing"

    click_on "Create Xml processing"

    assert_text "Xml processing was successfully created"
    click_on "Back"
  end

  test "should update Xml processing" do
    visit xml_processing_url(@xml_processing)
    click_on "Edit this xml processing", match: :first

    click_on "Update Xml processing"

    assert_text "Xml processing was successfully updated"
    click_on "Back"
  end

  test "should destroy Xml processing" do
    visit xml_processing_url(@xml_processing)
    click_on "Destroy this xml processing", match: :first

    assert_text "Xml processing was successfully destroyed"
  end
end
