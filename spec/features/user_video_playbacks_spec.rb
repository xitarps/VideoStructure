require 'rails_helper'

feature 'view video_playbacks index -' do
  context 'user' do
    it 'access successfully' do
      # Arrange
    
      # Act
      visit root_path
      click_on('Vídeos')
      # Assert
      expect(page).to have_content(I18n.t(:play_backs).capitalize)
    end
  end
end

feature 'Create video_playback -' do
  context 'user' do
    it 'successfully' do
      # Arrange
      
      # Act
      visit new_play_back_path
      fill_in I18n.t(:title).capitalize,	with: "Título teste" 
      fill_in I18n.t(:url).capitalize,	with: "https://teste.teste" 
      click_on(I18n.t(:save).capitalize)
      # Assert
      expect(page).to have_content("Título teste")
      expect(page).to have_content("https://teste.teste")
    end
  end
end

feature 'Read video_playback -' do
  context 'user' do
    it 'successfully' do
      # Arrange
      PlayBack.create(title: 'teste', url: 'https://teste', views:'2')
      # Act
      visit play_backs_path
      click_on(I18n.t(:destroy).capitalize)
      # Assert
      expect(page).not_to have_content("teste")
    end
  end
end

feature 'Update video_playback -' do
  context 'user' do
    it 'successfully' do
      # Arrange
      #PlayBack.create(title: 'teste', url: 'https://teste', views: 2)
      FactoryBot.create(:play_back)
      # Act
      visit play_backs_path
      click_on(I18n.t(:edit).capitalize)
      fill_in I18n.t(:title).capitalize,	with: "modTest"
      fill_in I18n.t(:url).capitalize,	with: "https://modificado"
      click_on(I18n.t(:save).capitalize)
      # Assert
      expect(page).to have_content("modTest")
      expect(page).not_to have_content("teste")
    end
  end
end

feature 'Delete video_playback -' do
  context 'user' do
    it 'successfully' do
      # Arrange
      FactoryBot.create(:play_back)
      # Act
      visit play_backs_path
      click_on(I18n.t(:destroy).capitalize)
      # Assert
      expect(page).not_to have_content("teste")
    end
  end
end

feature 'Create video_playback -' do
  context 'user' do
    it 'failure' do
      # Arrange
      
      # Act
      visit new_play_back_path 
      click_on(I18n.t(:save).capitalize)
      # Assert
      expect(page).to have_content("vazio")
    end
  end
end

feature 'Update video_playback -' do
  context 'user' do
    it 'successfully' do
      # Arrange
      #PlayBack.create(title: 'teste', url: 'https://teste', views: 2)
      FactoryBot.create(:play_back)
      # Act
      visit play_backs_path
      click_on(I18n.t(:edit).capitalize)
      fill_in I18n.t(:title).capitalize,	with: ""
      fill_in I18n.t(:url).capitalize,	with: ""
      click_on(I18n.t(:save).capitalize)
      # Assert
      expect(page).to have_content("vazio")
    end
  end
end