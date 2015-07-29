# change this file if more deb, pip or kerl packages are needed
default[:debs]      = ["vim",
                       "build-essential",
                       "curl",
                       "python-dev",
                       "python-setuptools",
                       "python-pip",
                       "python-virtualenv",
                       "virtualenvwrapper"]

default[:pips]      = ["ipython", 
                       "nose"]

default[:kerls]     = ["R16B03",
	                   "17.5",
	                   "18.0"]
