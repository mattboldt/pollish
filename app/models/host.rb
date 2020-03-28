class Host < Voter
  has_many :rooms, dependent: :destroy
end
