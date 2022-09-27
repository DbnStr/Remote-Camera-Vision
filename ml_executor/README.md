**Установка локального mqtt mosquitto сервера**
http://onreader.mdl.ru/MQTTProgrammingWithPython/content/Ch01.html

**Скачивание зависимостей Python** <br>
pipenv sync

Идентификатор mqtt-клиента генерируется автоматически в виде f'python-mqtt-{random.randint(0, 100)}' (в будущем возможна замена на uuid). </br>
Параметры настройки клиента для взаимодействия с брокером </br>
topic = 'recognition' </br>
host = localhost </br>
port = 1883 </br>

Сообщения имеюь следующий вид:
```json lines
{
  "image": image_encoded(str),
  "persons": {
    "id": person_id(int), //-1 если личность человека не установлена, иначе uuid4
    "name": person_name(str), // "Unknown" если личность человека не установлена
    "coordinates": [top(int), right(int), bottom(int), left(int)],
  },
  "time": cur_datetime(str)
}
```
