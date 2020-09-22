require 'rails_helper'

feature 'view homepage' do
  context 'user' do
    it 'successfully' do
      # Arrange
    
      # Act
      visit root_path

      # Assert
      expect(page).to have_content('Video Structure')
    end
  end
end