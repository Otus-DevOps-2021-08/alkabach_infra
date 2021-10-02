# alkabach_infra
alkabach Infra repository

## ДЗ 3

Данные для подключения

bastion_IP=62.84.117.16
someinternalhost_IP=10.128.0.16

Для подключения из консоли в одну команду, нужно добавить файл ~/.ssh/config с содержимым:

Host bastion
  HostName 62.84.117.16
  Port 22
  User appuser
  IdentityFile ~/.ssh/appuser

Host someinternalhost
  HostName 10.128.0.16
  ProxyJump bastion
  Port 22
  User appuser
  IdentityFile ~/.ssh/appuser

Подключение к web интерфейсу pritunl (с валидным ssl):
62.84.117.16.sslip.io
