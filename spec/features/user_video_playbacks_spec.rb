require 'rails_helper'

feature 'view video_playbacks index -' do
  context 'user' do
    it 'access successfully' do
      # Arrange
      user = FactoryBot.create(:user)
      login_as user, scope: :user

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
      user = FactoryBot.create(:user)
      login_as user, scope: :user
      
      # Act
      visit new_play_back_path
      fill_in I18n.t(:title).capitalize,	with: "Título teste"
      attach_file "Favor utilizar arquivos .mp4", "#{Rails.root}/spec/example/big_buck_bunny_240p_143k.mp4"
      click_on(I18n.t(:save).capitalize)
      # Assert
      expect(page).to have_content("criado.")
    end
  end
end

feature 'Read video_playback -' do
  context 'user' do
    it 'successfully' do
      # Arrange
      set_play_back
      # Act
      visit play_backs_path
      # Assert
      expect(page).to have_content("Título teste")
    end
  end
end

feature 'Update video_playback -' do
  context 'user' do
    it 'successfully' do
      # Arrange
      set_play_back
      # Act
      visit edit_play_back_path(PlayBack.first)
      fill_in I18n.t(:title).capitalize,	with: "modTest"
      click_on(I18n.t(:save).capitalize)
      # Assert
      expect(page).to have_content("modTest")
      expect(page).not_to have_content("Título teste")
    end
  end
end

feature 'Delete video_playback -' do
  context 'user' do
    it 'successfully' do
      # Arrange
      set_play_back
      # Act
      visit play_backs_path
      find('a.action_icons[data-method="delete"]').click
      # Assert
      expect(page).not_to have_content("Título teste")
    end
  end
end

feature 'Create video_playback -' do
  context 'user' do
    it 'failure' do
      # Arrange
      set_play_back
      # Act
      visit new_play_back_path 
      click_on(I18n.t(:save).capitalize)
      # Assert
      expect(page).to have_content("esquecido")
    end
  end
end

feature 'Update video_playback -' do
  context 'user' do
    it 'failure' do
      # Arrange
      set_play_back
      # Act
      visit play_backs_path
      find('a.action_icons[data-reason="edit"]').click
      fill_in I18n.t(:title).capitalize,	with: ""
      click_on(I18n.t(:save).capitalize)
      # Assert
      expect(page).to have_content("vazio")
    end
  end
end

def set_play_back
  user = FactoryBot.create(:user)
  login_as user, scope: :user
  visit new_play_back_path
  fill_in I18n.t(:title).capitalize,	with: "Título teste"
  attach_file "Favor utilizar arquivos .mp4", "#{Rails.root}/spec/example/big_buck_bunny_240p_143k.mp4"
  click_on(I18n.t(:save).capitalize)
end