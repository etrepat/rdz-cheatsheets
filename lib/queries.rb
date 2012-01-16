#### Lazy Loading

@posts = Post.where(:published => true)
if params[:order]
  # Encara no executem la consulta...
  @posts = @posts.order(params[:order])
end

...

# És en aquest moment quan s'executaria la consulta a la BD
@posts.each do |post|
  ...
end

# Podem, per tant, realitzar múltiples seleccions sense arribar
# a tocar la BD
posts         = Post.order(params[:order])
@published    = posts.where(:published => true)
@unpublished  = posts.where(:published => true)

#### CRUD (Create-Read-Update-Delete)
#
#     new(attributes)         delete(id_or_array)
#     create(attributes)      delete_all
#     create!(attributes)     update(ids, updates)
#     find(id_or_array)       update_all(updates)
#     destroy(id_or_array)    exists?
#     destroy_all
#
sports_post = Post.where(:category => 'sports')
new_sports_post = sports_post.new
# => 'sports'
new_sports_post.category

sports_posts.update_all(:published => false)
# => true
sports_posts.exists?

#### Consulta (métodes encadenables)
#
# Mètodes encadenables
#
#     where
#     having
#     select
#     group
#     order
#     limit
#     offset
#     joins
#     includes
#     lock
#     readonly
#     from
@posts = Post.where(:published => true).order(params[:order])

# Cridar a `.all` força la execució de la consulta i retorna un array, no
# una relació.
@joe_posts = Post.where(:author => "Joe").include(:comments).limit(10).all

#### Àmbits (Scopes)

class Post < ActiveRecordd::Base
  # Àmbit per defecte, s'executarà *sempre*
  default_scope order('title')

  # Crea l'àmbit `Post.published` i `Post.unpublished`
  scope :published, where(:published => true)
  scope :unpublished, where(:published => false)
end

# Podem definir scopes en Rails >= 3 com a mètodes estatics de la classe
# del model
class Post < ActiveRecord::Base
  default_scope order('title')

  class << self
    def published
      where(:published => true)
    end

    def unpublished
      where(:unpublished => true)
    end
  end
end
