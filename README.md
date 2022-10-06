# Remote-Camera-Vision

Целью данного проекта является создание простого, а главное удобного приложения для интеграции камер из различных мест в ваш смартфон. Оно позволяет:
* Просматривать данные с камер внутри мобильного приложения;
* Автоматически распознавать лица людей на видео, а также гибко уведомлять о распознавании (о чьем распознавании необходимо уведомлять, а о чьем не нужно);
* Интегрировать управление различными дополнительными устройствами вместе с камерами (например, замком двери);

Дополнительным преимуществом нашего решения является остутствие необходимости в создании сложной инфраструктуру для него, для подключения достаточно купить камеру с выходом в интернет.

## Применение проекта

Рассмотрим случаи и сферы, в которых наиболее эффективно и уместно применение нашего проекта:
* Система "умный глазок". Камера устанавливается около двери, а также подключается к системе RCV. Система будеи распознавать людей на видео и уведомлять пользователя о том, что "домой пришел Вася" или же, что "незнакомец находится у вашей двери". Внедрение такой системы для пользователя  будет эквивалентно стоимости камеры с выходом в интернет (примерно 2000 рублей), а также оплаты подписки на сервис.
* Системы с низкой степенью надежности аутентификации. То есть такие системы, ошибки в которых не будут носить большие риски. Например, турникеты на входе в университет, RCV будет автоматически распознавать студентов и осуществлять открытие турникета.

## Концептуальная архитектура

![image](https://user-images.githubusercontent.com/67962930/190469174-c26ffc86-4a3a-4b09-90b0-8eecc063284b.png)

Во взаимодействии участвуют следующие акторы
* Web-Client. Представляет собой камеру, у которой есть модуль для выхода в интернет. При взаимодействии с ML Executor играет роль веб клиента. Его задачей является передача видеопотока с камеры в ML Executor.
* ML Executor. Представляет собой сервер, на котором запущено работающее ML решение для распознавания лиц. Выполняет следующие функции:
  * Получает видеопоток с множества Web-Client;
  * Распознает лица на видео;
  * Публикует данные о распознавании в MQTT Broker;
* MQTT Broker. Является местом, куда ML Executor публикует данные и откуда MobileApp забирает данные (и наоборот);
* MobileApp. Представляет собой мобильное приложение пользователя, функция которого заключается в отображении данных (распознанные лица на различных камерах), полученных от ML Executor (через MQTT Broker).

## Архитектура компонента ML Executor

![Снимок экрана 2022-10-06 в 17 49 32](https://user-images.githubusercontent.com/67962930/194345145-fc97ea1d-8823-4ae3-8eeb-38c5fd5eceb9.png)

## Настройка

На данном этапе испольузется MQTT Broker, который запускается локально.
Гайд по установке MQTT сервера: http://onreader.mdl.ru/MQTTProgrammingWithPython/content/Ch01.html

Параметры настройки клиента для взаимодействия с брокером 
host = 127.0.0.1 
port = 1883 

Подключение возможно без предоставления логина и пароля.

Запуск MQTT Broker: mosquitto -c [Путь к файлу mosquitto.conf (содержится в основной папке проекта)]
