# テストでよく使用する共通処理
module SupportMethods
  def parsed_body
    JSON.parse(response.body)
  end


end