headings(){
  echo -e "\e[33mDisable Nginx\e[0m"
}
dnf module disable nginx -y &>>OUTPUT.log
dnf module enable nginx:1.26 -y &>>OUTPUT.log
dnf install -y nginx &>>OUTPUT.log

cp ngnix.conf /etc/nginx/nginx.conf &>>OUTPUT.log


curl -fsSL https://rpm.nodesource.com/setup_22.x | bash - &>>OUTPUT.log
dnf install -y nodejs &>>OUTPUT.log

node --version &>>OUTPUT.log
npm --version &>>OUTPUT.log

curl -L -o /tmp/frontend.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/frontend.tar.gz &>>OUTPUT.log
mkdir -p /tmp/frontend &>>OUTPUT.log
cd /tmp/frontend
tar xzf /tmp/frontend.tar.gz &>>OUTPUT.log

cd /tmp/frontend
npm ci &>>OUTPUT.log
npm run build &>>OUTPUT.log

rm -rf /usr/share/nginx/html/* &>>OUTPUT.log
cp -r /tmp/frontend/dist/* /usr/share/nginx/html/ &>>OUTPUT.log

systemctl enable nginx &>>OUTPUT.log
systemctl start nginx &>>OUTPUT.log