# Создание `jar`-файла на Scala
## Содержание

- [Инструменты](#Инструменты)
- [Установка `Scala` plugin для `IntelliJ`](#Установка-`Scala`-plugin-для-`IntelliJ`)
- [Создание `Scala`-проекта](#Создание-`Scala`-проекта)
- [Примеры исходного кода](#Примеры-исходного-кода)
- [Запуск MapReduce-вычислений для локальных файлов](#Запуск-MapReduce-вычислений-для-локальных-файлов)
- [Построение `jar`-файла](#Построение-`jar`-файла)
- [Запуск MapReduce `jar`-файла на YARN-кластере](#Запуск-MapReduce-`jar`-файла-на-YARN-кластере)

## Инструменты

Для начала необходимо установить :

- Ubuntu 14+ (with Python 3.x)
- Java 8
- Download Hadoop 3+
- IntelliJ 2019+ (for Scala code)
- (Optional) PyCharm 2019+ (for Python code)


## Установка `Scala` plugin для `IntelliJ`

`File` -> `Settings` -> `Plugins` -> Найти `Scala` plugin для `JetBrains` -> Нажать `Install` -> Перезагрузить IDE

## Создание `Scala`-проекта

`File` -> `New` -> `Project...` -> `Scala` with `sbt` -> Next ->  Name: `WordCountApp` - > Finish

Структура проекта:
```
App --> src --> main --> scala/
    |       |
    |       --> test --> scala/
    |    
    --> build.sbt

```


## Примеры исходного кода:

[WordCount.scala](./WordCountApp/src/main/scala/edu/classes/mr/WordCount.scala)

[build.sbt](./WordCountApp/build.sbt)

## Запуск MapReduce-вычислений для локальных файлов

1) `Run` -> `Edit Configurations...`
2) `Add new configuration...` для приложения
3) Установить следующую конфигурацию:
- Main class: `edu.classes.mr.WordCount` - (class с main-методом)
- Program-аргументы: `INPUT_LOCAL_FILE OUTPUT_LOCAL_DIR`
- Используйте путь к классу: `WordCountApp`
- остальное по-умолчанию

5) `Apply` -> `OK`
6) `Run` -> `Run...` -> Выберите Вашу конфигурацию

## Построение `jar`-файла

1. `File` -> `Project Structure...` -> `Artifacts`
2. `Add` -> `JAR` -> `Empty`
3. Переименуйте artifact в `word-count-scala-app`
4. Измените выходную директорию на `/FULL_PATH/WordCountApp/target`
5. Выберите `root jar` (`word-count-scala-app.jar`), а затем выберите `Create Manifest...`
6. Выберите `/FULL_PATH/WordCountApp/src/main/scala` directory -> OK
7. Main class: `edu.classes.mr.WordCount`
8. Добавьте `WordCountApp` в `jar` из `Available Elements`
9. Извлеките `sbt:org.scala-lang:scala-library:2.13.1:jar` в `jar` (необходимо извлечь, а не размещать `jar` в `root jar`)
10. `Apply` -> `OK`
11. `Build` -> `Build artifacts...` -> `word-count-scala-app` -> build

Если все сделано верно, Вы увидите `jar`-file в `target` каталоге Вашего проекта.

## Запуск MapReduce `jar`-файла на YARN-кластере

#### Запуск Hadoop:

Запустите `HDFS`:

`$HADOOP_HOME/sbin/start-dfs.sh`

Запустите `YARN`:

`$HADOOP_HOME/sbin/start-yarn.sh`

Запустите Job History Server:

`mapred --daemon start historyserver`

Проверьте, все ли службы запущены:

`jps`

#### Запуск `jar`:

Запустите приложение следующей командой:

`yarn jar ./target/word-count-scala-app.jar /data/yarn/reviews_Electronics_5_2.json /data/yarn/output`

Удалите выходную директорию, в случае необходимости:

`hdfs dfs -rm -r -f /data/yarn/output`
