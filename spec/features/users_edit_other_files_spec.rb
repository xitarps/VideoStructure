require 'rails_helper'

feature 'edit someone\'s playback -' do
  context 'user' do
    it 'failure' do
      # Arrange
      not_polite_user = FactoryBot.create(:user)
      set_play_back
      click_on(I18n.t(:log_out).capitalize)
      login_as not_polite_user, scope: :user
      # Act
      visit edit_play_back_path(id: 1)
      # Assert
      expect(page).to have_content(I18n.t(:play_backs).capitalize)
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
