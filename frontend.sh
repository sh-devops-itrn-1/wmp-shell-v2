source common.sh

headings "Disable Nginx"
dnf module disable nginx -y &>>OUTPUT.log
status_check $?

headings "Enable Nginx"
dnf module enable nginx:1.26 -y &>>OUTPUT.log
status_check $?

headings "Install Nginx"
dnf install -y nginx &>>OUTPUT.log
status_check $?


set -x
headings "Install Nodejs 22 repo"
curl -fsSL https://rpm.nodesource.com/setup_22.x | bash - &>>OUTPUT.log
status_check $?

headings "install nodejs"
dnf install -y nodejs &>>OUTPUT.log
status_check $?

headings "Nodejs version"
node --version &>>OUTPUT.log
status_check $?

headings "npm version"
npm --version &>>OUTPUT.log
status_check $?

headings "Download Application"
curl -L -o /tmp/frontend.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/frontend.tar.gz &>>OUTPUT.log
status_check $?

headings "Create frontend dir"
mkdir -p /tmp/frontend &>>OUTPUT.log
status_check $?

headings "copy nginx configuration"
cp ngnix.conf /etc/nginx/nginx.conf
status_check $?



headings "Change and Extract appl in frontend dir"
cd /tmp/frontend
tar xzf /tmp/frontend.tar.gz &>>OUTPUT.log
status_check $?


cd /tmp/frontend

headings "build application"
npm ci &>>OUTPUT.log
npm run build &>>OUTPUT.log
status_check $?

headings "remove default content of nginx"
rm -rf /usr/share/nginx/html/* &>>OUTPUT.log
status_check $?

headings "Copy app contents in nginx"
cp -r /tmp/frontend/dist/* /usr/share/nginx/html/ &>>OUTPUT.log
status_check $?

headings "Eanble nginx"
systemctl enable nginx &>>OUTPUT.log
status_check $?

headings "Start nginx"
systemctl start nginx &>>OUTPUT.log
status_check $?