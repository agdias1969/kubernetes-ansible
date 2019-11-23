
#useradd automation
#su - automation
#ssh-keygen
#visudo


for i in k8snode01 k8smaster01 k8snode02; do ssh root@$i 'ssh-keygen'; done
for i in k8smaster01 k8snode01 k8snode02; do ssh-copy-id -i /root/.ssh/id_rsa.pub root@$i; done

ansible all -u root -m user -a "name=automation password=$apr1$OXuYnI5S$2PB30FlsB6HapLijXgr0D/ generate_ssh_key=yes"
ansible all -u root -m copy -a "src=/etc/sudoers dest=/etc/sudoers"
ansible all -u root -m authorized_key -a "user=automation key={{lookup('file','/home/automation/.ssh/id_rsa.pub')}}"


kubeadm join 192.168.0.13:6443 --token ekrs8h.nkks6pgntvwde3e9 --discovery-token-ca-cert-hash sha256:5a36ce8a78e9bffb00c605d478ce6b3cf30fa9ba4a08d85b0169cac4e69da448 

	
3.15.2 Build 130326 Rel.58517n
