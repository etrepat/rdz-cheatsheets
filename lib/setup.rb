# Aquest *cheatsheet* mostra un exemple de com preparar un entorn
# de desenvolupament per a treballar amb Ruby/Rails.
#
# Es mostren exemples de com instal.lar: Git, GCC i utilitats en OSX i Linux.
#
# *Nota:* Algunes comandes poden haver quedat obsoletes o algunes llibreries
# anar per una versió superior.

#### OSX

#### [Homebrew](http://mxcl.github.com/homebrew/)
# *"Homebrew is the easiest and most flexible way to install the UNIX tools Apple
# didn't include with OS X."*

# En OSX utilitzarem [Homebrew](http://mxcl.github.com/homebrew/) com a
# gestor de paquets (tipus `apt-get`).

# Per instal.lar homebrew escrivim dins d'una finestra del terminal:
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

#### [Git](http://git-scm.org)

# Podem instal.lar [Git](http://git-scm.org) mitjançant un paquet binari
# directament de la pàgina o bé mitjançant `homebrew`:
$ brew install git

#### GCC

# Directament vía XCode (versió >= 4.1.x) ó només el compilador desde
# [http://git.io/osxgcc](http://git.io/osxgcc).

#### Motors de BD

# Podem instal.lar el motor de BD que tinguem pensat utilizar, utilitzant
# `homebrew` és fàcil:

# Instal.la SQLite
$ brew install sqlite3

# Instal.la l'RDBMS lliure PostgreSQL. Un cop hagi finalitzat, recordar
# seguir les instruccions en pantalla...
$ brew install postgresql

#### Linux (Tipus-Debian)

#### [Git](http://git-scm.org)

# En aquest cas directament des del gestor de paquets:
$ sudo apt-get install git-core

#### GCC i llibreries

# Per instal.lar les eines de compilació en un sistema debian:
$ sudo apt-get install build-essential

# També instal.larem un conjunt de llibreries que ens seran necessaries
# quan instal.lem algunes "gemes":
$ sudo apt-get install bison openssl libreadline6 libreadline6-dev curl zlib1g
zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev autoconf

#### RDBMS i altres

# SQLite 3
$ sudo apt-get install libsqlite3-0 libsqlite3-dev sqlite3

# PostgreSQL
$ sudo apt-get install postgresql postgresql-client postgresql-doc libpq-dev

# Imagemagick
$ sudo apt-get install imagemagick libmagickcore-dev libmagickwand-dev

# Etcétera
$ sudo apt-get install blah blah blah ...
