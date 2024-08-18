require "test_helper"

class XmlProcessingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xml_processing = xml_processings(:one)
  end

  test "should get index" do
    get xml_processings_url
    assert_response :success
  end

  test "should get new" do
    get new_xml_processing_url
    assert_response :success
  end

  test "should create xml_processing" do
    assert_difference("XmlProcessing.count") do
      post xml_processings_url, params: { xml_processing: {  } }
    end

    assert_redirected_to xml_processing_url(XmlProcessing.last)
  end

  test "should show xml_processing" do
    get xml_processing_url(@xml_processing)
    assert_response :success
  end

  test "should get edit" do
    get edit_xml_processing_url(@xml_processing)
    assert_response :success
  end

  test "should update xml_processing" do
    patch xml_processing_url(@xml_processing), params: { xml_processing: {  } }
    assert_redirected_to xml_processing_url(@xml_processing)
  end

  test "should destroy xml_processing" do
    assert_difference("XmlProcessing.count", -1) do
      delete xml_processing_url(@xml_processing)
    end

    assert_redirected_to xml_processings_url
  end
end
