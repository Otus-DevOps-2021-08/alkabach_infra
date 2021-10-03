# alkabach_infra
alkabach Infra repository

## ДЗ 3

Данные для подключения

bastion_IP=62.84.117.16

someinternalhost_IP=10.128.0.16

### Для подключения из консоли в одну команду, нужно добавить файл ~/.ssh/config с содержимым:

`$ ~/.ssh/config`
```
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
```

Подключение к web интерфейсу pritunl (с валидным ssl):

62.84.117.16.sslip.io

## ДЗ 4

Данные для подключения к приложению
```
testapp_IP=84.201.132.212
testapp_port=9292
```

Скрипты:
* [install_ruby.sh](https://github.com/Otus-DevOps-2021-08/alkabach_infra/blob/cloud-testapp/install_ruby.sh)
* [install_mongodb.sh](https://github.com/Otus-DevOps-2021-08/alkabach_infra/blob/cloud-testapp/install_mongodb.sh)
* [deploy.sh](https://github.com/Otus-DevOps-2021-08/alkabach_infra/blob/cloud-testapp/deploy.sh)

Создание виртуальной машины с развёрнутым образом приложения:

```
yc compute instance create \
  --name reddit-app \
  --metadata-from-file user-data=metadata.yaml \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1
```

* [metadata.yaml](https://github.com/Otus-DevOps-2021-08/alkabach_infra/blob/cloud-testapp/install_mongodb.sh) - файл метаданных, с помощью которого разворачивается ВМ с готовым приожением


## ДЗ 5

### Основное ДЗ

Создан конфиг packer [ubuntu16.json](https://github.com/Otus-DevOps-2021-08/alkabach_infra/blob/packer/ubuntu16.json)

Запуск сборки образа

`packer build -var-file=variables.json.example ubuntu16.json`

В результате получаем базовый образ виртуальной машины

### Дополнительное ДЗ

Создан конфиг packer с уже готовым приложением [immutable.json](https://github.com/Otus-DevOps-2021-08/alkabach_infra/blob/packer/immutable.json)

Запуск сборки образа
packer build -var-file=variables.json.example immutable.json

Создание ВМ с помощью Yandex.Cloud CLI

`sudo bash scripts/create_reddit_full_vm.sh`

Проверить созданный образ можно по адресу

`http://<внешний IP машины>:9292`
