# frozen_string_literal: true

require 'rails_helper'

#Integration Testing
RSpec.describe "Controller Test", type: :system do
    describe "Should reject user if personlities tests are not filled out" do
        it "Reject if try to click on Myers Briggs page" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "g@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "g"
            select "The Avoidant Turtle", from: "profile[ptanimal]"
            select "Green", from: "profile[pttruecolors]"
            select "Reformer", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("Profile must have MB test filled out to view this page.")
        end

        it "Reject if try to click on Conflict Management page" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "INFP", from: "profile[ptmyersbriggs]"
            select "Gold", from: "profile[pttruecolors]"
            select "Individualist", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("Profile must have result of Conflict Management test filled out to view this page.")
        end

        it "Reject if try to click on True Colors page" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "i@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "i"
            select "ENFJ", from: "profile[ptmyersbriggs]"
            select "The Collaborative Owl", from: "profile[ptanimal]"
            select "Enthusiast", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "True Colors"
            expect(page).to have_content("Profile must have result of True Colors test filled out to view this page.")
        end

        it "Reject if try to click on Enneagram page" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "ENTJ", from: "profile[ptmyersbriggs]"
            select "Blue", from: "profile[pttruecolors]"
            select "The Competitive Shark", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Profile must have result of Enneagram test filled out to view this page.")
        end
    end
end
#Ensure the matching algorithm is registering their personality type correctly for Myers Briggs
RSpec.describe "Controller Test", type: :system do
    describe "Should give user information about their personality results MB" do
        it "Show user their own personality type ENFP" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "g@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "g"
            select "ENFP", from: "profile[ptmyersbriggs]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Myers Briggs"
            expect(page).to have_content("Your Personality Type: ENFP")
        end
    end
end
#Ensure the matching algorithm is registering their personality type correctly for Conflict Management
RSpec.describe "Controller Test", type: :system do
    describe "Should give user information about their personality results Conflict Management" do
        it "Show user their own personality type Shark" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "The Competitive Shark", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("As a Shark, your best matches are teddy bears!")
        end
        it "Show user their own personality type Fox" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "The Compromising Fox", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("As a Shark, your best matches are teddy bears!")
        end
        it "Show user their own personality type Teddy Bear" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "The Accommodating Teddy Bear", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("As a Shark, your best matches are teddy bears!")
        end
        it "Show user their own personality type Owl" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "The Collaborative Owl", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("As a Shark, your best matches are teddy bears!")
        end
        it "Show user their own personality type Turtle" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "h@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "h"
            select "The Avoidant Turtle", from: "profile[ptanimal]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Conflict Management"
            expect(page).to have_content("As a Shark, your best matches are teddy bears!")
        end
    end
end
#Ensure the matching algorithm is registering their personality type correctly for True Colors
RSpec.describe "Controller Test", type: :system do
    describe "Should give user information about their personality results True Colors" do
        it "Show user their own personality type Gold" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "i@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "i"
            select "Gold", from: "profile[pttruecolors]"
            click_button "Create Profile"
            visit personalities_path
            click_link "True Colors"
            expect(page).to have_content("Your True Color: Gold")
        end
		
		it "Show user their own personality type Green" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "i@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "i"
            select "Green", from: "profile[pttruecolors]"
            click_button "Create Profile"
            visit personalities_path
            click_link "True Colors"
            expect(page).to have_content("Your True Color: Green")
        end
		
		it "Show user their own personality type Orange" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "i@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "i"
            select "Orange", from: "profile[pttruecolors]"
            click_button "Create Profile"
            visit personalities_path
            click_link "True Colors"
            expect(page).to have_content("Your True Color: Orange")
        end
		
		it "Show user their own personality type Blue" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "i@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "i"
            select "Blue", from: "profile[pttruecolors]"
            click_button "Create Profile"
            visit personalities_path
            click_link "True Colors"
            expect(page).to have_content("Your True Color: Blue")
        end
		
    end
end
#Ensure the matching algorithm is registering their personality type correctly for Enneagram
RSpec.describe "Controller Test", type: :system do
    describe "Should give user information about their personality results Enneagram" do
        it "Show user their own personality type Enthusiast" do
            visit new_profile_path
            click_link "Sign up"
            fill_in "user[email]", with: "j@gmail.com"
            fill_in "Password", with: "12345"
            click_button "Sign up"
            visit new_profile_path
            fill_in "Name", with: "j"
            select "Enthusiast", from: "profile[enneagram]"
            click_button "Create Profile"
            visit personalities_path
            click_link "Enneagram"
            expect(page).to have_content("Your ideal matches are Reformers and Investigators!")
        end
    end
end