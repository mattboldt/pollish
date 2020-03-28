class Room < ApplicationRecord
  include Hashid::Rails

  belongs_to :host, class_name: 'Voter'

end
