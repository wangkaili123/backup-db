# backup databases
  Support all databases and the database images can be find in docker.
  [X] Support for custom backup command.
  [X] The older files will be delete auto.
  [X] Can backup to another server.
  [ ] Email support.
  ### build docker images

  ```
  # build docker and run
  docker build . -t backup-db
  docker run -d backup-db
  ```
  ### client
  ```
  docker run -d \
  --name backup-test \
  -v /opt/backup-files-test:/app/backup-files \
  -e backup_server_ip=192.168.1.76 \
  -e backup_server_port=9977 \
  -e backup_project_name=test \
  -e backup_command="pg_dump -a \"host=192.168.1.11 port=5433 user=postgres password=password dbname=test\"" \
  -e max_save_days=30 \
  -e notice_email=277172506@qq.com \
  backup-db
  ```
  
  ### server
  ```
  docker run -d \
  --name backup-server \
  -p 9977:9977 \
  -v /opt/backup-files:/app/backup-files \
  -e backup_server_port=9977 \
  -e max_save_days=30 \
  -e notice_email=277172506@qq.com \
  backup-db
  ```