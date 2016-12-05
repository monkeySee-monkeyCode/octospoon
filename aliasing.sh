read -p "primary user?" user_name
read -p "Domain Name?" user_domain


sudo echo "postmaster: webmaster@"$user_domain"" >> /etc/aliases
sudo echo "root: webmaster@"$user_domain"" >> /etc/aliases
sudo echo "www-data: webmaster@"$user_domain"" >> /etc/aliases
sudo newaliases


sudo touch /etc/postfix/virtual-mailbox-domains
sudo echo ""$user_domain"      OK" >> /etc/postfix/virtual-mailbox-domains
sudo postmap /etc/postfix/virtual-mailbox-domains

sudo touch /etc/postfix/virtual-mailbox-users

sudo echo $user_name"@"$user_domain"              you@"$user_domain"" >> /etc/postfix virtual-mailbox-users
sudo echo "postbot@"$user_domain"          postbot@"$user_domain"" >> /etc/postfix virtual-mailbox-users
sudo echo "webmaster@"$user_domain"        webmaster@"$user_domain"" >> /etc/postfix virtual-mailbox-users

sudo postmap /etc/postfix/virtual-mailbox-users

sudo touch /etc/postfix/virtual

sudo echo $user_name"@"$user_domain"          you@"$user_domain"" >> /etc/postfix/virtual
sudo echo "postbot@"$user_domain"      postbot@"$user_domain"" >> /etc/postfix/virtual
sudo echo "webmaster@"$user_domain"    webmaster@"$user_domain"" >> /etc/postfix/virtual
sudo echo "postmaster@"$user_domain"   webmaster@"$user_domain"" >> /etc/postfix/virtual
sudo echo "root@mail."$user_domain"    webmaster@"$user_domain"" >> /etc/postfix/virtual
sudo echo "root@"$user_domain"         webmaster@"$user_domain"" >> /etc/postfix/virtual
sudo echo "abuse@"$user_domain"        webmaster@"$user_domain"" >> /etc/postfix/virtual
sudo echo "hostmaster@"$user_domain"   webmaster@"$user_domain"" >> /etc/postfix/virtual

sudo postmap /etc/postfix/virtual

sudo groupadd -g 5001 vmail
sudo useradd -g vmail -u 5001 vmail -d /var/mail/vmail -m

