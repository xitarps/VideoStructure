require 'rails_helper'

feature 'view homepage -' do
  context 'visitor' do
    it 'access successfully' do
      # Arrange
    
      # Act
      visit root_path

      # Assert
      expect(page).to have_content(I18n.t(:video_structure_main_title).capitalize)
    end
  end
end