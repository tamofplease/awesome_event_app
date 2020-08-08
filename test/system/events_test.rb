require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase

  setup do 
    sign_in_as(FactoryBot.create(:user))
  end
  
  test "/event/:id ページ表示" do 
    event = FactoryBot.create(:event)
    visit event_url(event)
    assert_selector "h1", text: event.name
  end

  test "/events/new ページの表示" do
    visit new_event_url
    assert_selector "h1", text: "イベント作成"

    fill_in "名前", with: "TokyuRubyKaigi"
    fill_in "場所", with: "Tokyo"
    fill_in "内容", with: "知育のかいぎ"

    start_at = Time.current
    end_at = start_at + 3.hour

    start_at_field = "event_start_at"
    select start_at.strftime("%Y"), from: "#{start_at_field}_1i"
    select I18n.l(start_at, format: '%B'), from: "#{start_at_field}_2i"
    select start_at.strftime("%-d"), from: "#{start_at_field}_3i"
    select start_at.strftime("%H"), from: "#{start_at_field}_4i"
    select start_at.strftime("%M"), from: "#{start_at_field}_5i"

    end_at_field = "event_end_at"
    select end_at.strftime("%Y"), from: "#{end_at_field}_1i"
    select I18n.l(end_at, format: '%B'), from: "#{end_at_field}_2i"
    select end_at.strftime("%-d"), from: "#{end_at_field}_3i"
    select end_at.strftime("%H"), from: "#{end_at_field}_4i"
    select end_at.strftime("%M"), from: "#{end_at_field}_5i"

    click_on "登録する"
    assert_selector "div.alert", text: "作成しました"
  end

  test "/events/:id ページを表示して削除ボタンを押す" do
    event = FactoryBot.create(:event, owner: current_user)
    visit event_url(event)
    assert_difference("Event.count", -1) do
      accept_confirm do
        click_on "イベントを削除する"
      end
      assert_selector "div.alert", text: "削除しました"
    end
  end

  # test "/ ページを表示して、未来のイベントは表示、過去のイベントは非表示であること" do
  #   future_event = FactoryBot.create(:event, start_at: Time.zone.now + 3.days)
  #   past_event = FactoryBot.create(:event, start_at: Time.zone.now + 1.days)

  #   travel_to Time.zone.now + 2.days do
  #     visit root_url 
  #     assert_selector "h5", text: future_event.name
  #     assert_no_selector "h5", text: past_event.name
  #   end
  # end
end
