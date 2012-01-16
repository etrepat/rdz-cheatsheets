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
  validates :size, :inclusion => { :in => %w(S M L XL),
    :message => "%{value} no es un tamany vàlid" }

  # Nombre
  validates :points, :numericality => true
  validates :games_played, :numericality => { :only_integer => true }

  # Permetre blancs / nul
  validates :title, :length => { :is => 5 }, :allow_blank => true
  validates :size, :inclusion => { :in => %w(S M L XL),,
    :message => "%{value} no es un tamany vàlid" }, :allow_nil => true

  # Es pot utilitzar `:on` per especificar quan executar la validació:
  # `:create` o `:update`
  validates :email, :uniqueness => true, :on => :create

  # També es pot condicionar les validacions al resultat d'un mètode (booleà)
  validates :card_number, :presence => true, :if => :paid_with_card?
end

#### Callbacks

class User < ActiveRecord::Base
  validates :login, :email, :presence => true

  # Abans de realitzar la validació crida al mètode `ensure_login_has_value`
  # per assegurar que aquest tingui un valor
  before_validation :ensure_login_has_a_value

  # Aquests són els callbacks disponibles:
  #
  # * `before_validation`
  # * `after_validation`
  # * `before_save`
  # * `before_create`
  # * `around_create`
  # * `after_create`
  # * `after_save`
  # * `before_destroy`
  # * `after_destroy`
  # * `around_destroy`

  # De la mateixa manera que amb les validacions, es pot executar un
  # callback de forma condicional amb `:if`:
  before_save :normalize_card_number, :if => :paid_with_card?

  protected

  def ensure_login_has_a_value
    if login.nil?
      self.login = email unless email.blank?
    end
  end

  # S'utilitza en el callback per a executar-lo o no
  def paid_with_card?
    order.payment_method == 'credit_card'
  end

  def normalize_card_number
    # ...
  end
end
