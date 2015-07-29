# change this file if more deb, pip or kerl packages are needed
default[:debs]  = ["vim",
                   "build-essential",
                   "curl",
                   "wget",
                   "git",
                   "iptables",
                   "python-dev",
                   "python-pip",
                   "python-virtualenv",
                   "virtualenvwrapper"]

default[:pips]  = ["setuptools",
                   "ipython", 
                   "nose",
                   "fancycompleter"]

default[:kerls] = ["R16B03",
                   "17.5",
                   "18.0"]
