# asdf should have been installed through brew first - See ../Brewfile

# Install useful plugins
. $(brew --prefix asdf)/asdf.sh

asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring;

asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git;

asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git;

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git;

asdf plugin-add golang https://github.com/kennyp/asdf-golang.git;

asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git;

asdf plugin-add 1password https://github.com/samtgarson/asdf-1password
