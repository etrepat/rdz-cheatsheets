#### Validacions

class Model < ActiveRecord::Base
  # Presència (no pot ser buit)
  validates :order_id, :presence => true

  # Únic
  validates :email, :uniqueness => true
  # Únic amb referència a un camp (àmbit)
  validates :name, :uniqueness => { :scope => :year,
    :message => "només un cop l'any" }
  # Únic amb opcions
  validates :name, :uniqueness => { :case_sensitive => false }

  # Longitud
  validates :content, :length => {
    :minimum   => 300,
    :maximum   => 400,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_short => "Ha de tenir almenys %{count} paraules",
    :too_long  => "Ha de tenir com a molt %{count} paraules"
  }
  validates :name,
    :presence => true,
    :length => { :within => 1..255, :allow_blank => true }

  # Format
  validates :legacy_code, :format => { :with => /\A[a-zA-Z]+\z/,
    :message => "Només caràcters alfabètics" }

  # Inclusió en un rang
  validates :size, :inclusion => { :in => %w(small medium large),
    :message => "%{value} is not a valid size" }

  # numericality
  validates :points, :numericality => true
  validates :games_played, :numericality => { :only_integer => true }    # Uses regex /\A[+-]?\d+\Z/




  # allow_blank
  validates :title, :length => { :is => 5 }, :allow_blank => true

  # allow_nil
  validates :size, :inclusion => { :in => %w(small medium large),
    :message => "%{value} is not a valid size" }, :allow_nil => true

  # on
  validates :email, :uniqueness => true, :on => :create

  # conditionals
  validates :card_number, :presence => true, :if => :paid_with_card?

end
