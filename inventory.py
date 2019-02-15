import sys, json, os, re
from subprocess import Popen, PIPE

TERRAFORM_WS_NAME = 'default'
TERRAFORM_PATH = 'terraform'
TERRAFORM_DIR = os.getcwd()

def get_tf_info():
    encoding = 'utf-8'
    tf_workspace = [TERRAFORM_PATH, 'workspace', 'select', TERRAFORM_WS_NAME]
    proc_ws = Popen(tf_workspace, cwd=TERRAFORM_DIR, stdout=PIPE, stderr=PIPE, universal_newlines=True)
    out_ws, err_ws = proc_ws.communicate()
    if err_ws != '':
        sys.stderr.write(str(err_ws) + '\n')
        sys.exit(1)
    else:
        tf_command = [TERRAFORM_PATH, 'state', 'pull', '-input=false']
        proc_tf_cmd = Popen(tf_command, cwd=TERRAFORM_DIR, stdout=PIPE, stderr=PIPE, universal_newlines=True)
        out_cmd, err_cmd = proc_tf_cmd.communicate()
        if err_cmd != '':
            sys.stderr.write(str(err_cmd)+ '\n')
            sys.exit(1)
        else:
            return json.loads(out_cmd, encoding=encoding)

tf_data = get_tf_info()

tmp = {}

for module in tf_data["modules"]:
    if "windows" in module["path"] or "ubuntu" in module["path"]:
        for resource in module["resources"]:
            compute = module["resources"][resource]
            ip = compute["primary"]["attributes"]["private_ip"]
            vm = compute["primary"]["attributes"]["display_name"]

            if "addc" in vm:
                if "addc" not in tmp:
                    tmp["addc"] = []
                tmp["addc"].append(ip)
            elif "vm" in vm:
                if "vm" not in tmp:
                    tmp["vm"] = []
                tmp["vm"].append(ip)
            elif "ansible" in vm:
                print(compute["primary"]["attributes"]["public_ip"])
                os.environ["UBUNTU_IP"] = compute["primary"]["attributes"]["public_ip"]

print(tmp)

if os.path.exists("./ansible/inventory.ini"):
    os.remove("./ansible/inventory.ini")

with open("./ansible/inventory.ini","w") as f:
    for t in tmp:
        ips = tmp[t]
        f.write("[" + t + "]\n")
        for i in ips:
            f.write(i + "\n")