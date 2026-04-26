source common.sh

headings "Install go"
dnf install -y golang
status_check $?

headings "go version"
go version
status_check $?

headings "Add appuser"
useradd -r -s /bin/false appuser
status_check $?

headings "Create application dir"
mkdir -p /app
status_check $?

headings "Download Auth-Service contents"
curl -L -o /tmp/auth-service.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/auth-service.tar.gz
status_check $?

headings "Change Dir"
cd /app
status_check $?

headings "Extract auth contents"
tar xzf /tmp/auth-service.tar.gz
status_check $?

headings "Build go binary"
cd /app
CGO_ENABLED=0 go build -o auth-service ./cmd/server
status_check $?

headings "Set ownership to appuser"
chown -R appuser:appuser /app
status_check $?

headings "remove others permissions"
chmod o-rwx /app -R
status_check $?

headings "Copy systemd service file"
cp auth-service.service /etc/systemd/system/auth-service.service
status_check $?

headings "Daemon reload"
systemctl daemon-reload
status_check $?

headings "Enable Service"
systemctl enable auth-service
status_check $?

headings "Start Service"
systemctl start auth-service
status_check $?
