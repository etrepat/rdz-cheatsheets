#### Generar migracions

# Generar una migració buida:
rails g[enerate] migration MyNewMigration

# Generar una migració amb els camps
rails g[enerate] migration add_fieldname_to_tablename fieldname:string

# Generar una migració a partir d'un model
rails g[enerate] model Product name:string description:text

#### Anatomia d'una migració

# Una migració és una subclasse de `ActiveRecord::Migration` i, a partir,
# de Rails 3.1 només cal que implementem el mètode `change`.
class CreateProducts < ActiveRecord::Migration
  def change
    # `create_table` crea una taula
    create_table :products do |t|
      # Els tipus de dades disponibles són:
      # `[:string, :text, :integer, :float, :decimal, :datetime, :timestamp, :time, :date, :binary, :boolean]`
      t.string  :name
      t.string  :reference_number
      t.text    :description

      # Podem especificar valors per defecte i si un camp accepta o no null
      t.float :price, :default => 0.0, :null => false

      # Afegim un camp `category_id` per a una relació `belongs_to`
      t.belongs_to :category, :null => false

      # Inserta els camps automàtics `created_at` i `updated_at`
      t.timestamps
    end

    # `add_index` crea un índex
    add_index :products, :category_id

    # Podem crear indexs únics i per més d'un camp
    add_index :products, [:name, :reference_number], :unique => true
  end
end

class ModifyProducts < ActiveRecord::Migration
  def change
    # Podem utilitzar també el mètode `change_table` per a realitzar modificacions
    # en una taula de forma similar:
    change_table :products do |t|
      # elimina les columnes `description` i `name`
      t.remove :description, :name

      # afegeix la columna `part_number`
      t.string :part_number

      # crea un index en la columna `part_number`
      t.index :part_number

      # renombra una columna: `upccode` -> `upc_code`
      t.rename :upccode, :upc_code
    end
  end
end
