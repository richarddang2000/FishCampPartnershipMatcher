# frozen_string_literal: true

require 'rails_helper'

# Integration Testing Controller Flash Notice
RSpec.describe 'Controller Test', type: :system do
  before(:all) do
    # Preference Form
    @form = PreferenceForm.create(title: 'Test', num_prefs: 2, num_antiprefs: 1, active: true)
    
    # Three Test Users
    @u_1 = User.create(id: 1, email: 'u1@gmail.com', role: 'Chair', approved: true)
    @u_2 = User.create(id: 2, email: 'u2@gmail.com', role: 'Chair', approved: true)
    @u_3 = User.create(id: 3, email: 'u3@gmail.com', role: 'Chair', approved: true)
    @p_1 = Profile.create(id: 1, user_id: @u_1.id, name: 'User 1', email: 'u1@gmail.com', ptanimal: 'The Collaborative Owl', pttruecolors: 'Orange', ptmyersbriggs: 'INTJ', enneagram: 'Achiever')
    @p_2 = Profile.create(id: 2, user_id: @u_2.id, name: 'User 2', email: 'u2@gmail.com', ptanimal: 'The Avoidant Turtle', pttruecolors: 'Gold', ptmyersbriggs: 'INFP', enneagram: 'Reformer')
    @p_3 = Profile.create(id: 3, user_id: @u_3.id, name: 'User 3', email: 'u3@gmail.com', ptanimal: 'The Compromising Fox', pttruecolors: 'Green', ptmyersbriggs: 'ENTP', enneagram: 'Investigator')

    # Mock Preferences
    @pref_1 = Preference.create(id: 1, selector_id: 1, selected_id: 2, preference_form_id: 1, pref_type: 'Preference', rating: 4)
    @pref_2 = Preference.create(id: 2, selector_id: 1, selected_id: 3, preference_form_id: 1, pref_type: 'Preference', rating: 4)
    @pref_3 = Preference.create(id: 3, selector_id: 2, selected_id: 1, preference_form_id: 1, pref_type: 'Preference', rating: 5)
    @pref_4 = Preference.create(id: 4, selector_id: 2, selected_id: 3, preference_form_id: 1, pref_type: 'Preference', rating: 3)
    @pref_5 = Preference.create(id: 5, selector_id: 3, selected_id: 1, preference_form_id: 1, pref_type: 'Preference', rating: 3)
    
    # Mock Q/A
    @q_1 = Question.create(id:1, preference_form_id: 1, question: 'Is this a quesiton?', question_type: 'Short Answer')
    @q_2 = Question.create(id:2, preference_form_id: 1, question: 'Is this a quesiton 2?', question_type: 'Multiple Choice')
    @q_3 = Question.create(id:3, preference_form_id: 1, question: 'Is this a quesiton 3?', question_type: 'True/False')
    @q_4 = Question.create(id:4, preference_form_id: 1, question: 'Is this a quesiton 4?', question_type: 'Numeric')
    @c_1 = Choice.create(id: 1, content: 'Possibly.', question_id: 2)
    @a_1 = Answer.create(user_id: 1, question_id: 1, preference_form_id: 1, answer_type: 'Short Answer', short_answer: 'This is in fact a question.')
    @a_2 = Answer.create(user_id: 1, question_id: 2, preference_form_id: 1, answer_type: 'Multiple Choice', multiple_choice: 'Possibly.')
    @a_3 = Answer.create(user_id: 1, question_id: 3, preference_form_id: 1, answer_type: 'True/False', true_false: true)
    @a_4 = Answer.create(user_id: 1, question_id: 4, preference_form_id: 1, answer_type: 'Numeric', numeric: 4)
  end
  
  before(:each) do
    # Match Entries
    @match_1 = Match.create(id: 1, user_id: 1, matched_id: nil)
    @match_2 = Match.create(id: 2, user_id: 2, matched_id: nil)
    @match_3 = Match.create(id: 3, user_id: 3, matched_id: nil)
  end

  describe 'proper message after a match has been made' do
    it 'should flash correct message in index' do
      director_login()
      visit edit_match_path(@match_1)
      click_button 'Match'
      expect(page).to have_content('Match updated successfully.')
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end
  
# Acceptance Test User Requirement
RSpec.describe 'Director', type: :system do
  before(:all) do
    # Preference Form
    @form = PreferenceForm.create(title: 'Test', num_prefs: 2, num_antiprefs: 1, active: true)
    
    # Three Test Users
    @u_1 = User.create(id: 1, email: 'u1@gmail.com', role: 'Chair', approved: true)
    @u_2 = User.create(id: 2, email: 'u2@gmail.com', role: 'Chair', approved: true)
    @u_3 = User.create(id: 3, email: 'u3@gmail.com', role: 'Chair', approved: true)
    @u_4 = User.create(id: 4, email: 'u4@gmail.com', role: 'Chair', approved: true)
    @u_5 = User.create(id: 5, email: 'u5@gmail.com', role: 'Chair', approved: true)
    @p_1 = Profile.create(id: 1, user_id: @u_1.id, name: 'User 1', email: 'u1@gmail.com', ptanimal: 'The Collaborative Owl', pttruecolors: 'Orange', ptmyersbriggs: 'INTJ', enneagram: 'Achiever')
    @p_2 = Profile.create(id: 2, user_id: @u_2.id, name: 'User 2', email: 'u2@gmail.com', ptanimal: 'The Avoidant Turtle', pttruecolors: 'Gold', ptmyersbriggs: 'INFP', enneagram: 'Reformer')
    @p_3 = Profile.create(id: 3, user_id: @u_3.id, name: 'User 3', email: 'u3@gmail.com', ptanimal: 'The Compromising Fox', pttruecolors: 'Green', ptmyersbriggs: 'ENTP', enneagram: 'Investigator')
    @p_4 = Profile.create(id: 4, user_id: @u_4.id, name: 'User 4', email: 'u4@gmail.com', ptanimal: 'The Competitive Shark', pttruecolors: 'Blue', ptmyersbriggs: 'ISTJ', enneagram: 'Achiever')
    @p_5 = Profile.create(id: 5, user_id: @u_5.id, name: 'User 5', email: 'u5@gmail.com', ptanimal: 'The Accommodating Teddy Bear', pttruecolors: 'Orange', ptmyersbriggs: 'ESTP', enneagram: 'Enthusiast')
    
    # Mock Preferences
    @pref_1 = Preference.create(id: 1, selector_id: 1, selected_id: 2, preference_form_id: 1, pref_type: 'Preference', rating: 4)
    @pref_2 = Preference.create(id: 2, selector_id: 1, selected_id: 3, preference_form_id: 1, pref_type: 'Preference', rating: 4)
    @pref_3 = Preference.create(id: 3, selector_id: 2, selected_id: 1, preference_form_id: 1, pref_type: 'Preference', rating: 5)
    @pref_4 = Preference.create(id: 4, selector_id: 2, selected_id: 3, preference_form_id: 1, pref_type: 'Preference', rating: 3)
    @pref_5 = Preference.create(id: 5, selector_id: 3, selected_id: 1, preference_form_id: 1, pref_type: 'Preference', rating: 3)
    @pref_6 = Preference.create(id: 6, selector_id: 4, selected_id: 5, preference_form_id: 1, pref_type: 'Preference', rating: 3)
  end

    before(:each) do
    # Match Entries
    @match_1 = Match.create(id: 1, user_id: 1, matched_id: nil)
    @match_2 = Match.create(id: 2, user_id: 2, matched_id: nil)
    @match_3 = Match.create(id: 3, user_id: 3, matched_id: nil)
    @match_4 = Match.create(id: 4, user_id: 4, matched_id: nil)
    @match_5 = Match.create(id: 5, user_id: 5, matched_id: nil)
  end
  
  it 'matches User 1 and User 2' do
    director_login()
    visit edit_match_path(@match_1)
    click_button 'Match'
    expect(Match.find(1).matched_id).to eq(2)
    expect(Match.find(2).matched_id).to eq(1)
  end

  it 'matches User 3 and 1 after User 1 and 2 are already matched' do
    director_login()
    visit edit_match_path(@match_1)
    click_button 'Match'
    visit edit_match_path(@match_3)
    click_button 'Match'
    expect(Match.find(1).matched_id).to eq(3)
    expect(Match.find(2).matched_id).to eq(nil)
    expect(Match.find(3).matched_id).to eq(1)
  end

  it 'views User 1\'s existing partner while looking for a match for User 3' do
    director_login()
    visit edit_match_path(@match_1)
    click_button 'Match'
    visit edit_match_path(@match_3)
    click_link 'View Partner'
    expect(page).to have_content(@p_1.name)
    expect(page).to have_content(@p_2.name)
  end

  it 'wants to see all of the unmatched chairs while trying to find a new match for User 1' do
    director_login()
    visit edit_match_path(@match_1)
    click_button 'Match'
    visit edit_match_path(@match_1)
    click_link 'Unmatched Chairs'
    expect(page).to have_content(@p_1.name)
    expect(page).to have_content(@p_3.name)
  end

  it 'matches User 1 and User 2 through the search dropdown' do
    director_login()
    visit edit_match_path(@match_1)
    click_button 'Search by name'
    click_link @p_2.name
    expect(page).to have_content(@p_1.name)
    expect(page).to have_content(@p_2.name)
    click_button 'Match'
    expect(Match.find(1).matched_id).to eq(2)
    expect(Match.find(2).matched_id).to eq(1)
  end

  it 'tries to find an unmatched chair after all other chairs already have a partner' do
    director_login()
    visit edit_match_path(@match_1)
    click_button 'Match'
    visit edit_match_path(@match_4)
    click_button 'Match'
    visit edit_match_path(@match_3)
    click_link 'Unmatched Chairs'
    expect(page).to have_content(@p_3.name)
    expect(page).to have_content('Warning: All other chairs already have a partner.')
  end

  it 'tries to find a match for someone who has no prospects' do
    director_login()
    u_6 = User.create(id: 6, email: 'u6@gmail.com', role: 'Chair', approved: true)
    p_6 = Profile.create(id: 6, user_id: u_6.id, name: 'User 6', email: 'u6@gmail.com')
    match_6 = Match.create(id: 6, user_id: 6, matched_id: nil)

    visit edit_match_path(match_6)
    expect(page).to have_content('Warning: This chair has no prospects.')
  end

  it 'is trying to find a match for a user that no other chair has selected as a preference' do
    director_login()
    visit edit_match_path(@match_4)
    click_button 'Match'
    expect(page).to have_content('Match updated successfully.')
  end
  
  it 'starts matching and a new match average turns out to be better than a previous one' do
    director_login()
    u_6 = User.create(id: 6, email: 'u6@gmail.com', role: 'Chair', approved: true)
    u_7 = User.create(id: 7, email: 'u7@gmail.com', role: 'Chair', approved: true)

    Profile.create(id: 6, user_id: u_6.id, name: 'User 6', email: 'u6@gmail.com')
    Profile.create(id: 7, user_id: u_7.id, name: 'User 7', email: 'u7@gmail.com')

    Preference.create(id: 7, selector_id: 5, selected_id: 6, preference_form_id: 1, pref_type: 'Preference', rating: 3)
    Preference.create(id: 8, selector_id: 6, selected_id: 5, preference_form_id: 1, pref_type: 'Preference', rating: 3)
    Preference.create(id: 9, selector_id: 5, selected_id: 7, preference_form_id: 1, pref_type: 'Preference', rating: 5)
    Preference.create(id: 10, selector_id: 7, selected_id: 5, preference_form_id: 1, pref_type: 'Preference', rating: 5)

    match_6 = Match.create(id: 6, user_id: 6, matched_id: nil)
    match_7 = Match.create(id: 7, user_id: 7, matched_id: nil)

    visit edit_match_path(@match_5)
    click_button 'Match'
    expect(page).to have_content('Match updated successfully.')
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end
