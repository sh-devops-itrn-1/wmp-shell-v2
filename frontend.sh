source common.sh

headings "Disable Nginx"
dnf module disable nginx -y &>>OUTPUT.log

headings "Enable Nginx"
dnf module enable nginx:1.26 -y &>>OUTPUT.log

headings "Install Nginx"
dnf install -y nginx &>>OUTPUT.log

headings "copy nginx configuration"
cp ngnix.conf /etc/nginx/nginx.conf &>>OUTPUT.log

headings "Install Nodejs 22 repo"
curl -fsSL https://rpm.nodesource.com/setup_22.x | bash - &>>OUTPUT.log

headings "install nodejs"
dnf install -y nodejs &>>OUTPUT.log

headings "Nodejs version"
node --version &>>OUTPUT.log

headings "npm version"
npm --version &>>OUTPUT.log

headings "Download Application"
curl -L -o /tmp/frontend.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/frontend.tar.gz &>>OUTPUT.log

headings "Create frontend dir"
mkdir -p /tmp/frontend &>>OUTPUT.log

headings "Change and Extract appl in frontend dir"
cd /tmp/frontend
tar xzf /tmp/frontend.tar.gz &>>OUTPUT.log


cd /tmp/frontend

headings "build application"
npm ci &>>OUTPUT.log
npm run build &>>OUTPUT.log

headings "remove default content of nginx"
rm -rf /usr/share/nginx/html/* &>>OUTPUT.log

headings "Copy app contents in nginx"
cp -r /tmp/frontend/dist/* /usr/share/nginx/html/ &>>OUTPUT.log

headings "Eanble nginx"
systemctl enable nginx &>>OUTPUT.log

headings "Start nginx"
systemctl start nginx &>>OUTPUT.log