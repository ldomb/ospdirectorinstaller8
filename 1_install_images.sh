echo "install images"
sudo yum install -y rhosp-director-images rhosp-director-images-ipa
cp /usr/share/rhosp-director-images/overcloud-full-latest-8.0.tar ~/images/.
cp /usr/share/rhosp-director-images/ironic-python-agent-latest-8.0.tar ~/images/.
cd ~/images
echo "untar images"
for tarfile in *.tar; do tar -xf $tarfile; done
echo "setting ifnames and root password"
virt-customize -a overcloud-full.qcow2 --edit /etc/default/grub:s/net.ifnames=0/net.ifnames=1/
virt-customize -a overcloud-full.qcow2 --edit /root/anaconda-ks.cfg:s/net.ifnames=0/net.ifnames=1/
virt-customize --root-password password:laurent -a overcloud-full.qcow2

echo "upload images"
openstack overcloud image upload --image-path /home/stack/images/
echo "verify images"
openstack image list
echo "check /httpboot"
ls -l /httpboot
