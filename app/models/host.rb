class Host < Voter
  has_many :rooms, dependent: :destroy

  accepts_nested_attributes_for :rooms
end
