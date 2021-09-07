# テストでよく使用する共通処理
module SupportMethods
  def parsed_body
    JSON.parse(response.body)
  end

  shared_examples '許可しないユーザー' do |proc|
    let(:invalid_headers) { payload_headers }

    it 'ヘッダーにトークンが存在しない' do
      proc.call('うんこ')
    end

    # it 'ヘッダーに無効なトークンが存在する' do
    #   expect(type).to eq 'unko'
    # end
  end
end
