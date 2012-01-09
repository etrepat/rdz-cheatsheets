# [RVM](http://beginrescueend.com/) ens permet gestionar diferents versions
# d'intérprets de Ruby, gemes, per-usuari etc.

# Per a instal.lar-lo:
$ bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)

# Afegim a `.bashrc` o `.bash_profile` per a carregar RVM automàticament:
$ [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

#### Rubies

# Llista els intérprets de Ruby coneguts:
$ rvm list known

# Instal.la una versió de Ruby:
$ rvm install 1.9.3

# Utilitza una versió de Ruby:
$ rvm use 1.9.2
Using /Users/user/.rvm/gems/ruby-1.9.2-p290
$ ruby -v
ruby 1.9.2p290 (2011-07-09 revision 32553) [x86_64-darwin11.0.0]

# Utilitzar una versió de Ruby per defecte:
$ rvm use 1.9.3 --default
Using /Users/user/.rvm/gems/ruby-1.9.3-p0

#### Gemsets

# Crear un gemset:
$ rvm gemset create rails31
Gemset 'rails31' created.

# Utilitzar-lo canviant de ruby:
$ rvm use 1.9.3@rails31 [--create]
Using /Users/user/.rvm/gems/ruby-1.9.3-p0 with gemset rails31
# Les gemes s'instal.laran dins el gemset `rails31` dins la versió
# de ruby 1.9.3
$ gem install blah

# Utilitzar un gemset dins el Ruby actual
$ rvm gemset use rails31

# Llistar els gemsets disponibles
$ rvm gemset list

# Eliminar un gemset
$ rvm gemset delete rails31

# Gemset `global`, accessible per a tots els gemsets:
$ rvm use 1.9.3@global
# Les gemes instal.lades aquí es faran disponibles en els nous
# gemsets
$ gem install bundler

#### `.rvmrc`
# rvm pot utilitzar automàticament una versió de ruby i/o un gemset
# quan accedim a un directori:
echo "rvm use 1.9.3@rails31" > ~/projects/project_name/.rvmrc

# Més informació a [http://rvm.beginrescueend.com](http://rvm.beginrescueend.com)
