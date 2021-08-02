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
  org = Organization.first_or_create do |org|
    org.ein = org_node.css("EIN").text
    org.name = org_node.css("Name").text.strip
  end
  puts org.ein
  puts org.name

  org.addresses << Address.first_or_create do |address|
    address.line_1 = org_node.css("USAddress AddressLine1").text
    address.city = org_node.css("USAddress City").text
    address.state = org_node.css("USAddress State").text
    address.zip = org_node.css("USAddress ZIPCode").text
  end

  f.css("Return ReturnData IRS990ScheduleI RecipientTable").each do |award_info|
    org.awards << Award.create do |award|
      award.amount = award_info.css("AmountOfCashGrant").text
      award.purpose = award_info.css("PurposeOfGrant").text
    end
  end
end

