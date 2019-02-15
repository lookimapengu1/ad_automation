import sys, json, os, re
from subprocess import Popen,PIPE

TERRAFORM_WS_NAME = 'default'
TERRAFORM_PATH = 'terraform'
TERRAFORM_DIR = os.getcwd()

encoding = 'utf-8'
tf_workspace = [TERRAFORM_PATH, 'workspace', 'select', TERRAFORM_WS_NAME]
proc_ws = Popen(tf_workspace, cwd=TERRAFORM_DIR, stdout=PIPE, stderr=PIPE, universal_newlines=True)
out_ws, err_ws = proc_ws.communicate()
if err_ws != '':
    sys.stderr.write(str(err_ws) + '\n')
    sys.exit(1)
else:
    print(str(out_ws))