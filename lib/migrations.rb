#### Línea de comandes

# Generar una migració buida:
rails g[enerate] migration MyNewMigration

# Generar una migració amb els camps
rails g[enerate] migration add_fieldname_to_tablename fieldname:string

# Generar una migració a partir d'un model ó scaffold
rails g[enerate] model Product name:string description:text
rails g[enerate] scaffold Product name:string description:text

# Executa les migracions pendents (no executades)
rake db:migrate

# Executa les migracions necessàries (amunt o avall) fins a una versió específica
rake db:migrate VERSION=XXX

# Desfer els canvis realitzats en l'última migració
rake db:rollback

# Desfer les 3 últimes migracions
rake db:rollback STEP=3

#### Anatomia d'una migració

# Una migració és una subclasse de `ActiveRecord::Migration` i, a partir,
# de Rails 3.1 només cal que implementem el mètode `change`.
class CreateProducts < ActiveRecord::Migration
  def change
    # Aquí definim els mètodes que actuaran amb la nostra base de dades d'entre
    # els que podem utilitzar es troben:
    # * `create_table`
    # * `change_table`
    # * `drop_table`
    # * `add_column`
    # * `change_column`
    # * `rename_column`
    # * `remove_column`
    # * `add_index`
    # * `remove_index`
    # * `execute` => per realitzar comandes SQL
  end

#### Creant taules

class CreateProducts < ActiveRecord::Migration
  def change
    # `create_table` crea una taula. Admet com a segon paràmetre (opcional) un
    # hash amb algunes opcions com per exemple `:id => false` per a no
    # generar automàticament un camp `id` autonumeric.
    # Ex:
    #     create_table :products, :id => false do |t|
    #     ...
    #     end
    create_table :products do |t|
      # Els tipus de dades que tenim disponibles i, per tant, soportats per
      # ActiveRecord són:
      # `[:primary_key, :string, :text, :integer, :float, :decimal, :datetime,
      # :timestamp, :time, :date, :binary, :boolean]`
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

    # Utilitzem `add_index` per a generar índexs
    add_index :products, :category_id

    # Els índexs poden, evidentment, ser únics i afectar més d'un camp
    add_index :products, [:name, :reference_number], :unique => true
  end
end

#### Modificant taules

class ModifyProducts < ActiveRecord::Migration
  def change
    # Utilitzem el mètode `change_table` per a realitzar modificaciones
    # en una taula de forma homònima a `create_table`:
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

# En comptes d'utilitzar `change_table` també hauriem pogut utilitzar
# els mètodes individuals. El següent executa les mateixes modificacions
# que l'anterior, però és més explícit:

class ModifiyProducts < ActiveRecord::Migration
  def change
    # eliminem les columnes `description` i `name`
    remove_column :products, :description
    remove_column :products, :name

    # afegim la columna `part_number`
    add_column :products, :part_number, :string

    # generem un índex per al camp `part_number`
    add_index :products, :part_number

    # renombra una columna: `upccode` -> `upc_code`
    rename_column :products, :upccode, :upc_code
  end
end

#### Referències

class CreateProducts < ActiveRecord::Migration
  def change
    # Genera automàticament una columna `category_id` del tipus adeqüat. Utilitzem
    # el nom del mòdel, no el de la columna.
    t.references :category

    # També podem utilizar `t.belongs_to :category`.

    # També ho podem utilizar en associacions `belongs_to` polimòrfiques i
    # ActiveRecord afegira les dues columnes (id i tipus).
    t.references :attachment, :polymorphic => {:default => 'Photo'}
    # En aquest cas es crearien les columnes `attachment_id` i `attachment_type`,
    # aquesta última amb el valor per defecte `Photo`
  end
end

#### SQL

class ModifiyProducts < ActiveRecord::Migration
  def change
    # Utiltizem `execute` per a llençar "queries" SQL directament. Per exemple,
    # per a crear una clau forània:
    execute <<-SQL
      ALTER TABLE products
        ADD CONSTRAINT fk_products_categories
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
    SQL
  end
end
