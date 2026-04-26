source common.sh


headings "Install postgresql16 repo"
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
status_check $?

headings "Disable postgresql"
dnf -qy module disable postgresql
status_check $?

headings "Install postgresql16-server "
dnf install -y postgresql16-server postgresql16
status_check $?

headings "Initialize DB"
/usr/pgsql-16/bin/postgresql-16-setup initdb


headings "Change the Listen_address"
sed -i "/#listen_addresses/ c listen_addresses = '*'" /var/lib/pgsql/16/data/postgresql.conf
status_check $?

headings "copy the configuration file with changes"
cp pg_hba.conf /var/lib/pgsql/16/data/pg_hba.conf
status_check $?

headings "Enable postgresql16"
systemctl enable postgresql-16
status_check $?

headings "Restart postgresql16"
systemctl restart postgresql-16
status_check $?

headings "Input Schema"
sudo -u postgres /usr/pgsql-16/bin/psql -f schema.sql
status_check $?
