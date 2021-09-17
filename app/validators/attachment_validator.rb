class AttachmentValidator < ActiveModel::EachValidator
  include ActiveSupport::NumberHelper

  MAX_BYTE_SIZE = 10_485_760
  VALID_CONTENT_TYPE = %r{\Aimage/(png|jpeg)\Z}

  def validate_each(record, attribute, value)
    return if value.blank? || !value.attached?

    has_error = false

    if value.is_a?(ActiveStorage::Attached::Many)
      value.each do |one_value|
        unless validate_maximum(record, attribute, one_value)
          has_error = true
          break
        end
      end
    else
      has_error = true unless validate_maximum(record, attribute, value)
    end

    if value.is_a?(ActiveStorage::Attached::Many)
      value.each do |one_value|
        unless validate_content_type(record, attribute, one_value)
          has_error = true
          break
        end
      end
    else
      has_error = true unless validate_content_type(record, attribute, value)
    end

    record.send("#{attribute}=", nil) if has_error
  end

  private

  def validate_maximum(record, attribute, value)
    if value.byte_size > MAX_BYTE_SIZE
      record.errors[attribute] << (options[:message] || "は#{number_to_human_size(MAX_BYTE_SIZE)}以下にしてください")
      false
    else
      true
    end
  end

  def validate_content_type(record, attribute, value)
    if value.content_type.match?(VALID_CONTENT_TYPE)
      true
    else
      record.errors[attribute] << (options[:message] || "#{value.content_type}は対応できないファイル形式です")
      false
    end
  end
end
