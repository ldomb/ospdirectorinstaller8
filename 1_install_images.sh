sudo yum install -y rhosp-director-images rhosp-director-images-ipa
cp /usr/share/rhosp-director-images/overcloud-full-latest-8.0.tar ~/images/.
cp /usr/share/rhosp-director-images/ironic-python-agent-latest-8.0.tar ~/images/.
cd ~/images
for tarfile in *.tar; do tar -xf $tarfile; done
openstack overcloud image upload --image-path /home/stack/images/
