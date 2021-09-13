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
end
