function taocl() {
    curl -s https://raw.githubusercontent.com/jlevy/the-art-of-command-line/master/README.md |
      pandoc -f markdown -t html |
      xmlstarlet fo --html --dropdtd |
      xmlstarlet sel -t -v "(html/body/ul/li[count(p)>0])[$RANDOM mod last()+1]" |
      xmlstarlet unesc | fmt -80
}

function exists() {
    command -v "$1" 2>/dev/null
}

function exists_cuda {
    if exists nvidia-smi; then
        return 1
    else
        return -1
    fi
}

function usegpu {
	export CUDA_DEVICES_ORDER=PCI_BUS_ID
	export CUDA_VISIBLE_DEVICES=$1
}

### add this to ~/.zshrc (or ~/.bashrc if you're using Bash)
create_x86_conda_environment () {
  # create a conda environment using x86 architecture
  # first argument is environment name, all subsequent arguments will be passed to `conda create`
  # example usage: create_x86_conda_environment myenv_x86 python=3.9
  
  CONDA_SUBDIR=osx-64 conda create -n $@
  conda activate $1
  conda config --env --set subdir osx-64
}
