class Api::RoomSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :name, :hashid

  has_one :latest_poll, serializer: :poll, record_type: :poll
end
