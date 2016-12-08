sudo apt-get install aptitude
suod apt-get install git

echo "installing postfix/dovecot mail stack -=SUDO=-"

sudo aptitude mail-delivery-stack
sudo aptitude install python-software-properties
sudo add-apt-repository ppa:malte.swart/dovecot-2.2
sudo aptitude update
sudo aptitude upgrade
