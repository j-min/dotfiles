# Configuration file for ipython.
c = get_config()

# Don't open browser when launching jupyter
c.NotebookApp.open_browser = False

# Automatic autoimport
c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']
