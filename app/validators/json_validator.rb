# frozen_string_literal: true

class JsonValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # 全てのプロパティに過不足がないかチェック
    JSON::Validator.validate!(options[:schema], value, strict: true)
    length_validate(record, value)
  rescue JSON::Schema::ValidationError => e
    record.errors[attribute] << (options[:message] || e.message)
  end

  private

  # southとnorthは-90~90,westとeastは-180~180の間かチェック
  def length_validate(record, value)
    value.each do |k, v|
      case k
      in 'north' | 'south'
        record.errors[k] << "expected -90 to 90, but entered #{v}" unless (-90..90).include?(v)
      in 'west' | 'east'
        record.errors[k] << "expected -180 to 180, but entered #{v}" unless (-180..180).include?(v)
      end
    end
  end
end
