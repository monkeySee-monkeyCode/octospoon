# run me
#bash < <(curl -sL  https://raw.github.com/monkeySee-monkeyCode/octobot/post-dove-setup.sh)


echo "installing aptitude package manager -=SUDO=-"
sudo apt-get install aptitude
suod apt-get install git

echo "installing postfix/dovecot mail stack -=SUDO=-"

sudo aptitude mail-delivery-stack
sudo aptitude install python-software-properties
sudo add-apt-repository ppa:malte.swart/dovecot-2.2
sudo aptitude update
sudo aptitude upgrade


echo "installing spamassassin mail filter -=SUDO=-"

aptitude install spamass-milter pyzor razor libmail-dkim-perl spamassassin sa-compile spamd
adduser --shell /bin/false --home /var/lib/spamassassin --disabled-password --disabled-login --gecos "" spamd
usermod -a -G spamd spamass-milter
sudo mkdir -p /var/spool/postfix/spamassassin
sudo chown spamd:root /var/spool/postfix/spamassassin/
sa-update
sudo chown -R spamd:spamd /var/lib/spamassassin
sudo mkdir -p /var/lib/spamassassin/.spamassassin
sudo chown spamd:spamd /var/lib/spamassassin/.spamassassin
usermod -a -G spamd spamass-milter
mkdir -p /var/lib/spamassassin/.razor
mkdir -p /var/lib/spamassassin/.pyzor
mkdir -p /var/lib/spamassassin/.spamassassin
pyzor --homedir /var/lib/spamassassin/.pyzor discover
razor-admin -home=/var/lib/spamassassin/.razor -register
razor-admin -home=/var/lib/spamassassin/.razor -create
razor-admin -home=/var/lib/spamassassin/.razor -discover
chown -R spamd:spamd /var/lib/spamassassin
mkdir -p /var/mail/vmail/sieve-before
mkdir -p /var/mail/vmail/sieve-after
chown -R vmail:vmail /var/mail/vmail/sieve-before
chown -R vmail:vmail /var/mail/vmail/sieve-after



echo "installing OpenDKIM"

sudo aptitude install opendkim opendkim-tools
sudo mkdir -p /etc/opendkim
sudo chown opendkim:opendkim /etc/opendkim
cd /etc/opendkim
echo "generating DKIM"
opendkim-genkey -r -h sha256 -d mail.yourdomain.com -s mail
sudo mv mail.private mail
sudo touch KeyTable
sudo touch SigningTable
sudo touch TrustedHosts
sudo chown -R opendkim:opendkim /etc/opendkim
sudo mkdir -p /var/spool/postfix/opendkim
sudo chown opendkim:root /var/spool/postfix/opendkim
#sudo usermod -G opendkim postfix

sudo chmod +x ~/aliasing.sh
sudo chmod +x ~/reconfig.sh
sudo ./aliasing.sh
sudo ./reconfig.sh

sudo service postfix restart
sudo service dovecot restart
sudo service spamd restart


#bash < <(curl -sL  https://raw.github.com/monkeySee-monkeyCode/octospoon/reconfig.sh)

#bash < <(curl -sL  https://raw.github.com/monkeySee-monkeyCode/octobospoon/aliasing.sh)
