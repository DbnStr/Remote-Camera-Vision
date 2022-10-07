**Установка локального mqtt mosquitto сервера**
http://onreader.mdl.ru/MQTTProgrammingWithPython/content/Ch01.html

**Скачивание зависимостей Python** <br>
pipenv sync

Идентификатор mqtt-клиента генерируется автоматически в виде f'python-mqtt-{random.randint(0, 100)}' (в будущем возможна замена на uuid). </br>
Параметры настройки клиента для взаимодействия с брокером </br>
host = localhost </br>
port = 1883 </br>

## Публикация текущего состояния камеры

Раз в 2 секунды ML Executor публикует в MQTT Broker информацию о текущем состоянии камеры. </br>
topic = 'current_view' </br>

Сообщения публикуются в формате JSON и имеют следующий вид:
```
{
  "image": image_encoded (str), //Изображение кодируется с помощью метода base64
  "time": cur_datetime(str)
}
```

## Добавление записи о распознавании

Когда ML Executor распознаёт людей на фото, он публикует в MQTT Broker информацию о распозновании. </br>
topic = 'recognition' </br>

Сообщения публикуются в формате JSON и имеют следующий вид:
```
{
  "image": image_encoded(str), //Изображение кодируется с помощью метода base64
  "persons": [
    {
      "id": person_id(str), //-1 если личность человека не установлена, иначе uuid4
      "name": person_name(str), // "Unknown" если личность человека не установлена
      "coordinates": {
        "top": top(int), 
        "right": right(int), 
        "bottom": bottom(int), 
        "left": left(int)
      }
    },
    ...
  ],
  "time": cur_datetime(str)
}
```

## Добавление нового распознаваемого человека

MobileApp отправляет сообщение с набором фото и именем нового распознаваемого человка. </br>

Сообщения публикуются в формате JSON и имеют следующий вид:
```
{
  "name": person_name(str), //Имя добавляемого человека. Например, "Вася"
  "photos": [ //Содержит набор фотографий, закодированных с помощью метода base64
    person_photo(str), 
    ...
  ],
}
```
