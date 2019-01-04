# Configuration file for jupyter-notebook.

c = get_config()

# Do not open web broswer
c.NotebookApp.open_browser = False

# Open to all IP
c.NotebookApp.ip = '0.0.0.0'

# c.NotebookApp.port = 8888

# ipython
# from notebook.auth import passwd
# passwd()
c.NotebookApp.password = u'sha1:....'
