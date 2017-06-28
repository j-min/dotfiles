# Configuration file for ipython.
c = get_config()

# Automatic autoimport
c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']
