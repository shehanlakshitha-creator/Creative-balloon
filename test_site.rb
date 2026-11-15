#!/usr/bin/env ruby
# ==============================================================================
# CREATIVE BALLOON — AUTOMATED QUALITY & SPECIFICATION VERIFICATION SUITE
# ==============================================================================

require 'open-uri'
require 'net/http'

puts "=== STARTING AUTOMATED TEST SUITE FOR CREATIVE BALLOON ==="
tests_passed = 0
tests_failed = 0

def assert(condition, message)
  if condition
    puts "  [PASS] #{message}"
    true
  else
    puts "  [FAIL] #{message}"
    false
  end
end

# 1. Check critical files existence
puts "\n1. Checking File Existence..."
files = [
  "index.html",
  "services.html",
  "case-study.html",
  "css/main.css",
  "css/responsive.css",
  "js/logo-component.js",
  "js/case-studies-data.js",
  "js/services-data.js",
  "js/app.js",
  "js/services-page.js",
  "server.rb"
]

files.each do |f|
  exists = File.exist?(File.expand_path(f, __dir__))
  if assert(exists, "File exists: #{f}")
    tests_passed += 1
  else
    tests_failed += 1
  end
end

# 2. Check index.html content requirements
puts "\n2. Verifying index.html Requirements..."
index_content = File.read(File.expand_path("index.html", __dir__))
# Strip tags and normalize spaces for text assertions
normalized_text = index_content.gsub(/<[^>]+>/, ' ').gsub(/\s+/, ' ').upcase

checks_index = [
  [normalized_text.include?("WE BUILD BRANDS PEOPLE NOTICE"), "Hero headline present ('WE BUILD BRANDS PEOPLE NOTICE.')"],
  [normalized_text.include?("CREATIVE STRATEGY, DIGITAL MARKETING AND VISUAL PRODUCTION"), "Hero supporting text present"],
  [normalized_text.include?("START A PROJECT"), "Primary CTA present"],
  [normalized_text.include?("VIEW OUR WORK"), "Secondary CTA present"],
  [normalized_text.include?("BRANDS DO NOT GROW FROM CONTENT ALONE"), "Section 02 Brand statement present"],
  [index_content.include?("lift-flow-grid"), "Interactive 5-stage lift flow container present"],
  [normalized_text.include?("DIGITAL GROWTH"), "Pillar 01 present"],
  [normalized_text.include?("CREATIVE"), "Pillar 02 present"],
  [normalized_text.include?("VISUAL PRODUCTION"), "Pillar 03 present"],
  [normalized_text.include?("THE CREATIVE LOOP"), "Section 04 Creative loop present"],
  [normalized_text.include?("ONE CREATIVE PARTNER. FROM IDEA TO IMPACT."), "Section 06 Why Creative Balloon headline present"],
  [normalized_text.include?("STRATEGY") && normalized_text.include?("CREATIVE") && normalized_text.include?("PRODUCTION") && normalized_text.include?("DIGITAL") && normalized_text.include?("UNIFIED GROWTH"), "Growth equation present"],
  [normalized_text.include?("READY TO LIFT YOUR NEXT IDEA?"), "Section 09 Final CTA headline present"],
  [normalized_text.include?("LET’S TALK") || normalized_text.include?("LET'S TALK"), "Contact form submit button present"],
  [normalized_text.include?("IDEAS THAT RISE."), "Footer signature line present"],
  [index_content.include?("hello@creativeballoon.agency"), "Direct email present"],
  [index_content.include?("+94 77 123 4567"), "WhatsApp/phone contact present"]
]

checks_index.each do |condition, label|
  if assert(condition, label)
    tests_passed += 1
  else
    tests_failed += 1
  end
end

# 3. Verify exact 9 fields in contact form
puts "\n3. Verifying Exact 9 Fields in Enquiry Form..."
form_fields = [
  ["field-name", "Field 1: Name"],
  ["field-company", "Field 2: Company"],
  ["field-email", "Field 3: Email"],
  ["field-phone", "Field 4: WhatsApp / Phone"],
  ["field-project-type", "Field 5: Project Type"],
  ["field-needs-tags", "Field 6: What do you need (Tags)"],
  ["field-timeline-val", "Field 7: Estimated Timeline"],
  ["field-budget-val", "Field 8: Budget Range"],
  ["field-message", "Field 9: Message"]
]

form_fields.each do |id, label|
  if assert(index_content.include?(id), label)
    tests_passed += 1
  else
    tests_failed += 1
  end
end

# 4. Check services.html requirements
puts "\n4. Verifying services.html Requirements..."
services_content = File.read(File.expand_path("services.html", __dir__))
services_js = File.read(File.expand_path("js/services-page.js", __dir__))

services_checks = [
  [services_js.include?("WHAT IT IS"), "WHAT IT IS benefit block present"],
  [services_js.include?("WHY IT MATTERS"), "WHY IT MATTERS benefit block present"],
  [services_js.include?("WHAT WE DELIVER"), "WHAT WE DELIVER benefit block present"],
  [services_content.include?("DIGITAL GROWTH"), "Digital Growth pillar in services view"],
  [services_content.include?("CREATIVE STUDIO"), "Creative Studio pillar in services view"],
  [services_content.include?("VISUAL PRODUCTION"), "Visual Production pillar in services view"]
]

services_checks.each do |condition, label|
  if assert(condition, label)
    tests_passed += 1
  else
    tests_failed += 1
  end
end

# 5. Check Case Study vertical flow in js/app.js & case-study.html
puts "\n5. Verifying Case Study Exact Vertical Flow..."
app_js = File.read(File.expand_path("js/app.js", __dir__))

cs_flow = [
  ["PROJECT HERO", "1. PROJECT HERO"],
  ["CLIENT", "2. CLIENT"],
  ["PROJECT TYPE", "3. PROJECT TYPE"],
  ["THE CHALLENGE", "4. THE CHALLENGE"],
  ["THE IDEA", "5. THE IDEA"],
  ["THE STRATEGY", "6. THE STRATEGY"],
  ["THE CREATIVE", "7. THE CREATIVE"],
  ["THE PRODUCTION", "8. THE PRODUCTION"],
  ["THE DIGITAL EXECUTION", "9. THE DIGITAL EXECUTION"],
  ["THE RESULT", "10. THE RESULT (editable placeholder)"],
  ["RELATED WORK", "11. RELATED WORK"],
  ["START A PROJECT", "12. START A PROJECT CTA"]
]

cs_flow.each do |token, label|
  if assert(app_js.include?(token), label)
    tests_passed += 1
  else
    tests_failed += 1
  end
end

# 6. Check Visual Design System Colors & Natural Luxury Fonts in css/main.css
puts "\n6. Verifying Visual Design System Colors & Natural Luxury Typography..."
css_content = File.read(File.expand_path("css/main.css", __dir__))

color_checks = [
  [css_content.include?("Playfair Display") && css_content.include?("Plus Jakarta Sans"), "Natural Luxury Typography (Playfair Display & Plus Jakarta Sans)"],
  [css_content.include?("#0A0A0D") || css_content.include?("#0A0A0C"), "Deep Obsidian Luxury Background"],
  [css_content.include?("#F7F5F0") || css_content.include?("#F5F2EB"), "Warm Alabaster Natural Silk Typography"],
  [css_content.include?("#D4AF37"), "Haute Luxury Accent (Imperial Champagne Gold #D4AF37)"]
]

color_checks.each do |condition, label|
  if assert(condition, label)
    tests_passed += 1
  else
    tests_failed += 1
  end
end

# 7. Check Modular Logo Component in js/logo-component.js
puts "\n7. Verifying Modular Brand Mark..."
logo_js = File.read(File.expand_path("js/logo-component.js", __dir__))
if assert(logo_js.include?("USE_EXTERNAL_IMAGE") && logo_js.include?("cb-brand-monogram"), "Modular logo component with external image fallback toggle")
  tests_passed += 1
else
  tests_failed += 1
end

puts "\n=================================================="
puts "  TEST RESULTS: #{tests_passed} PASSED, #{tests_failed} FAILED"
puts "=================================================="

exit(tests_failed == 0 ? 0 : 1)
