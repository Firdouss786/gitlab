require "application_system_test_case"
require 'rubyXL'
require 'rubyXL/convenience_methods/cell'
require 'rubyXL/convenience_methods/workbook'
require 'rubyXL/convenience_methods/worksheet'

class BomUploadTest < ApplicationSystemTestCase

  setup do
    browser_sign_in_as users(:chris)
    @fleet = fleets(:A380)
    @file = "test/fixtures/uploads/bom_upload.xlsx"
    workbook = RubyXL::Parser.parse(@file)
    @worksheet = workbook['BOM']
    @new_file = "test/fixtures/uploads/bom_copy.xlsx"
  end

  def teardown
    File.delete(@new_file) if File.file?(@new_file)
  end

  test "bom file must be in .xlsx format" do
    visit new_bom_upload_path(@fleet)
    click_on "Upload BOM"
    assert_selector '[data-test-id="error_explanation"]', text: "File missing or not in .xlsx format."
  end

  test "bom upload via excel file" do
    visit new_bom_upload_path(@fleet)

    attach_file('file', @file)
    click_on "Upload BOM"

    assert_selector '[data-test-id="error_explanation"]', text: "Added #{@worksheet.count - 1} rows successfully."
  end

  test "reuploading same file will not add duplicates" do
    visit new_bom_upload_path(@fleet)

    attach_file('file', @file)
    click_on "Upload BOM"
    assert_selector '[data-test-id="error_explanation"]', text: "Added #{@worksheet.count - 1} rows successfully."

    visit new_bom_upload_path(@fleet)
    attach_file('file', @file)
    click_on "Upload BOM"
    assert_selector '[data-test-id="error_explanation"]', text: "Added 0 rows successfully."
  end

  test "missing required columns will raise error" do
    visit new_bom_upload_path(@fleet)

    FileUtils.cp(@file, @new_file)

    workbook = RubyXL::Parser.parse(@new_file)
    worksheet = workbook['BOM']
    worksheet.delete_column(0)
    workbook.write(@new_file)

    attach_file('file', @new_file)
    click_on "Upload BOM"
    assert_selector '[data-test-id="error_explanation"]', text: "Upload unsuccessful, missing reuqired columns for Products."

    File.delete(@new_file)
  end

  test "empty columns will raise error" do
    visit new_bom_upload_path(@fleet)

    FileUtils.cp(@file, @new_file)

    workbook = RubyXL::Parser.parse(@new_file)
    worksheet = workbook['BOM']
    worksheet[2][0].change_contents("")
    workbook.write(@new_file)

    attach_file('file', @new_file)
    click_on "Upload BOM"
    assert_selector '[data-test-id="error_explanation"]', text: "Product Part Number is missing in row 2."

    File.delete(@new_file)
  end

end
