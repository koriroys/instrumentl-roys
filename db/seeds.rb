# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

files = [
  "http://s3.amazonaws.com/irs-form-990/201132069349300318_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201612429349300846_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201521819349301247_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201641949349301259_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201921719349301032_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201831309349303578_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201823309349300127_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201401839349300020_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201522139349100402_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201831359349101003_public.xml"
]

files.each do |file|
  puts file
  f = Nokogiri::XML(URI.open(file))

  org_node = f.css("Return ReturnHeader Filer").first
  org = Organization.find_or_create_by(
    ein: org_node.css("EIN").text,
    name: org_node.css("Name").text.strip.gsub(/\n */, " ").presence || org_node.css("BusinessName").text.strip.gsub(/\n */, " ").presence || org_node.css("BusinessNameLine1Txt").text.strip.gsub(/\n */, " ")
  )

  org.addresses |= [Address.find_or_create_by(
    line_1: org_node.css("USAddress AddressLine1").text,
    city: org_node.css("USAddress City").text,
    state: org_node.css("USAddress State").text,
    zip: org_node.css("USAddress ZIPCode").text
  )]

  f.css("Return ReturnData IRS990ScheduleI RecipientTable").each do |award_info|
    organization = Organization.find_or_create_by(
      name: award_info.css("RecipientNameBusiness BusinessNameLine1").text.presence || award_info.css("RecipientBusinessName BusinessNameLine1").text.presence || award_info.css("RecipientBusinessName BusinessNameLine1Txt").text,
      ein: award_info.css("EINOfRecipient").text.presence || award_info.css("RecipientEIN").text,
    )

    organization.addresses |= [Address.find_or_create_by(
      line_1: award_info.css("AddressUS AddressLine1").text.presence || award_info.css("USAddress AddressLine1").text.presence || award_info.css("USAddress AddressLine1Txt").text,
      city: award_info.css("AddressUS City").text.presence || award_info.css("USAddress City").text.presence || award_info.css("USAddress CityNm").text,
      state: award_info.css("AddressUS State").text.presence || award_info.css("USAddress State").text.presence || award_info.css("USAddress StateAbbreviationCd").text,
      zip: award_info.css("AddressUS ZIPCode").text.presence|| award_info.css("USAddress ZIPCode").text.presence || award_info.css("USAddress ZIPCd").text
    )]

    organization.awards |= [Award.create(
      amount: award_info.css("AmountOfCashGrant").text.presence || award_info.css("CashGrantAmt").text,
      purpose: award_info.css("PurposeOfGrant").text.presence || award_info.css("PurposeOfGrantTxt").text
    )]
  end
end

