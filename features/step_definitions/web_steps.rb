Given(/^a user Mary signed in as "(.*?)" to Blue Troll application$/) do |role|
end

When(/^Mary selects "(.*?)" menu item$/) do |menu_item|
	visit crews_path
	click_link "Crews"
end

Then(/^she can see the list of all registered crews$/) do
end
