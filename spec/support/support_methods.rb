# テストでよく使用する共通処理
module SupportMethods
  def parsed_body
    JSON.parse(response.body)
  end

  shared_context 'STI default values setup' do |type|
    let(:map) { create(:map) }
    let(:attr) {
      attr = attributes_for(type)
      attr['map_id'] = map.id
      attr
    }
  end

  def attach_file(record)
    setting = { io: File.open("#{Rails.root}/spec/fixtures/files/test_img.png"),
                filename: 'test_img.png',
                content_type: 'image/png' }

    case record
    when User
      record.avatar.attach(setting)
    when Todo
      record.images.attach(setting)
    else
      nil
    end
  end
end
