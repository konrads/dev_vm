default[:pips]      = ["ipython==0.12.1", 
                       "nose==1.1.2"]

# FIXME: Can this be narrowed down, insignificant dependencies removed?
default[:debs]      = [# "vim=2:7.3.429-2ubuntu2.1",
                       "build-essential=11.5ubuntu2.1",
                       "curl=7.22.0-3ubuntu4.3",
                       "python-dev=2.7.3-0ubuntu2.2",
                       "python-setuptools=0.6.24-1ubuntu1",
                       "python-pip=1.0-1build1",
                       "python-virtualenv=1.7.1.2-1",
                       "virtualenvwrapper=2.11.1-2"]

default[:kerls]     = ["R16B03","17.5","18"]

## hardcoded globals - DO NOT CHANGE
default[:virtualenv] = "dev"