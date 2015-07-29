# Global params
debs            = node[:debs]
pips            = node[:pips]
kerls           = node[:kerls]
virtualenv_name = "dev"
os_user         = "vagrant"
home_dir        = "/home/#{os_user}"
pip_cache       = "#{home_dir}/.pip"
virtualenv_root = "#{home_dir}/.virtualenvs/#{virtualenv_name}"
no_cache_opts   = "-o Acquire::http::No-Cache=True"

# Due to potential for broken downloads (suspecting culprit = http proxies) - setting no cache on the update
execute "apt update" do
  command "sudo apt-get update"
  user "root"
end

# install debs
debs.each do |deb_info|
  deb_name, deb_ver = deb_info.split "=", 2
  package deb_name do
    version deb_ver
    # options no_cache_opts
  end
end

# virtualenv installation
execute "Create virtualenv" do
  user os_user
  command "virtualenv #{virtualenv_root}"
  not_if { File.exists?(virtualenv_root) }
end

# ensure the cache is created
# directory pip_cache do
#   action :create
#   owner os_user
#   group os_user
# end
# install all pips
pips.each do |pip|
  execute "Installing pip #{pip}" do
    user os_user
    command "#{virtualenv_root}/bin/pip install --log=#{home_dir}/.pip.log --download-cache=#{pip_cache} #{pip}"
  end
end

home_files = [".bash_profile", ".bashrc"]   # virtualenv related
home_files.each do |f|
  template "#{home_dir}/#{f}" do
    source "home/#{f}"
    owner os_user
    group os_user
    mode "0644"
  end
end

# create bin dir where utils will go
directory "#{home_dir}/bin" do
  action :create
  owner os_user
  group os_user
end

# fetch kerl
remote_file "#{home_dir}/bin/kerl" do
  source "https://raw.github.com/spawngrid/kerl/master/kerl"
  mode "0755"
end
# build & install Erlang packages
execute "Kerl update" do
  user os_user
  command "#{home_dir}/bin/kerl update releases"
end
kerls.each do |kerl_p|
  installed_release = "#{home_dir}/.kerl/installed-releases/#{kerl_p.downcase}"
  execute "Kerl build #{kerl_p.upcase}" do
    user os_user
    creates "#{home_dir}/.kerl/builds/#{kerl_p.downcase}"
    environment ({"HOME" => home_dir})
    command "#{home_dir}/bin/kerl build #{kerl_p.upcase} #{kerl_p.downcase}"
  end
  execute "Kerl install #{kerl_p.upcase}" do
    user os_user
    creates installed_release
    environment ({"HOME" => home_dir})
    command "#{home_dir}/bin/kerl install #{kerl_p.downcase} #{installed_release}"
  end
end

# fetch rebar
remote_file "#{home_dir}/bin/rebar" do
  source "https://github.com/rebar/rebar/wiki/rebar"
  mode "0755"
end
