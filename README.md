# Remote-Camera-Vision

Цель данного проекта является создание простого, а главное удобного приложения для интеграции камер из различных мест в ваш смартфон. Оно позволяет:
* Просматривать данные с камер внутри мобильного приложения;
* Автоматически распознавать лица людей на видео, а также гибко уведомлять уведомлениями о распознавании (о чьем распознавании необходимо уведомлять, а о чьем не нужно);
* Интегрировать управление различными дополнительными устройствами вместе с камерами (например, замком двери);

Дополнительным преимуществом нашего решения является остутствие необходимости в создании сложной инфраструктуру для него, для подключения к нему будет достаточно купить камеру с выходом в интернет.

## Применение проекта

Рассмотрим случаи и сферы, в которых наиболее эффективно и уместно применение нашего проекта:
* Система "умный глазок". Камера устанавливается около двери, а также подключается к системе RCV. Система будеи распознавать людей на видео и уведомлять пользователя о том, что "домой пришел Вася" или же, что "незнакомец находится у вашей двери". Внедрение такой системы для пользователя  будет эквивалентно стоимости камеры с выходом в интернет (примерно 2000 рублей), а также оплаты подписки на сервис.
* Системы с низкой степенью надежности аутентификации. То есть такие системы, ошибки в которых не будут носить большие риски. Например, турникеты на входе в университет

![image](https://user-images.githubusercontent.com/67962930/190469174-c26ffc86-4a3a-4b09-90b0-8eecc063284b.png)

## Настройка

На данном этапе испольузется MQTT Broker, который запускается локально.
Гайд по установке MQTT сервера: http://onreader.mdl.ru/MQTTProgrammingWithPython/content/Ch01.html

Параметры настройки клиента для взаимодействия с брокером 
host = 127.0.0.1 
port = 1883 

Подключение возможно без предоставления логина и пароля.

Запуск MQTT Broker: mosquitto -c [Путь к файлу mosquitto.conf (содержится в основной папке проекта)]

