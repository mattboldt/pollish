class Api::OptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
