# Создание Java-проекта в IntelliJ
Приведен пример создания проекта для вычисления среднего рейтинга товаров и пользовательских счетчиков.

## Содержание:

- [Инструменты](#Инструменты)
- [Конфигурация](#Конфигурация)
- [Создание Java-проекта в IntelliJ](#Создание-Java-проекта-в-IntelliJ)
- [Исходный код на Java](#Исходный-код-на-Java)
- [Выполнение MapReduce-вычислений на локальных файлах](#Выполнение-MapReduce-вычислений-на-локальных-файлах)
- [Построение `jar` файла на `maven`](#Построение-`jar`-файла-на-`maven`)
- [Выполнение MapReduce `jar` файла на YARN-кластере](#Выполнение-MapReduce-`jar`-файла-на-YARN-кластере)

## Инструменты

Для выполнения необходимо установить следующие инструменты:

- Ubuntu 14+
- Java 8
- Hadoop 3+
- IntelliJ 2019+ (for Java code)

## Конфигурация

#### Hadoop:

- `hadoop/bin` - hadoop-команды
- `hadoop/sbin/` - скрипты
- `hadoop/etc/hadoop` - конфигурация
- `hadoop/logs` - hadoop-логи

Конфигурация для HDFS и YARN:

- `hadoop/etc/hadoop/hadoop-env.sh`
- `hadoop/etc/hadoop/core-site.xml` ([default values](https://hadoop.apache.org/docs/r3.1.2/hadoop-project-dist/hadoop-common/core-default.xml))
- `hadoop/etc/hadoop/hdfs-site.xml` ([default values](https://hadoop.apache.org/docs/r3.1.2/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml))
- `hadoop/etc/hadoop/yarn-env.sh`
- `hadoop/etc/hadoop/yarn-site.xml` ([default values](https://hadoop.apache.org/docs/r3.1.2/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)) - параметры конфигурации
- `hadoop/etc/hadoop/capacity-scheduler.xml`

Конфигурационные файлы можно найти [здесь](https://github.com/SergUSProject/BigDataProc_HomeWorks/tree/main/HomeWork_1/base/config)

#### MapReduce:

 Конфигурационные файлы MapReduce:

- `hadoop/etc/hadoop/mapred-env.sh` - переопределите `hadoop-env.sh` для всей работы, выполняемой `mapred` и связанными командами
- `hadoop/etc/hadoop/mapred-site.xml` ([default values](https://hadoop.apache.org/docs/r3.1.2/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)) - конфигурационные параметры

Правила:

- `mapred-env.sh` > `hadoop-env.sh` > жестко заданные значения по-умолчанию
- `MAPRED_xyz` > `HADOOP_xyz` > жестко заданные значения по-умолчанию

Установите `YARN` как framework для MapReduce приложений

```
<property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
    <description>The runtime framework for executing MapReduce jobs.
    Can be one of local, classic or yarn.
    </description>
</property>
```

Команды для загрузки конфигурационных файлов:

```
wget -O ~~/BigData/hadoop/etc/hadoop/mapred-site.xml https://raw.githubusercontent.com/SergUSProject/BigDataProc_HomeWorks/main/HomeWork_1/base/config/mapreduce/mapred-site.xml
```

#### Запуск Hadoop-кластера

Запуск `HDFS`:

```
$HADOOP_HOME/sbin/start-dfs.sh
```

Запуск `YARN`:

```
$HADOOP_HOME/sbin/start-yarn.sh
```

Запуск Job History Server:

```
mapred --daemon start historyserver
```

Проверка запуска всех служб:

```
jps
```

## Создание Java-проекта в IntelliJ (v2019.2+)

1) Открыть IntelliJ
2) Выбрать `Create New Project` или `File` -> `Project...`
3) Выбрать Maven и project SDK 1.8 -> `Next`
4) GroupId: `edu.classes.mr`; ArtifactId: `average-rating-app` -> `Next`
4) Имя проекта: AverageRatingApp -> `Finish`

## Исходный код на Java

1. [pom.xml](./AverageRatingApp/pom.xml)
2. [Review model class](./AverageRatingApp/src/main/java/edu/classes/mr/Review.java)
3. [Custom writable class](./AverageRatingApp/src/main/java/edu/classes/mr/StatsTupleWritable.java)
4. [Enum for json parsing result](./AverageRatingApp/src/main/java/edu/classes/mr/ReviewState.java)
5. [Driver class](./AverageRatingApp/src/main/java/edu/classes/mr/AvgRatingDriver.java)
6. [Mapper class](./AverageRatingApp/src/main/java/edu/classes/mr/AvgRatingMapper.java)
7. [Reducer class](./AverageRatingApp/src/main/java/edu/classes/mr/AvgRatingReducer.java)
8. Test class: `TODO`

## Выполнение MapReduce-вычислений на локальных файлах

1) `Run` -> `Edit Configurations...`
2) `Add new configuration...` for Application
3) Main class: `edu.classes.mr.AvgRatingDriver` - (class c main-методом)
4) Program arguments: `INPUT_LOCAL_FILE OUTPUT_LOCAL_DIR`
5) `Apply` -> `OK`
6) `Run` -> `Run...` -> Choose your configuration

Content of the output file (`part-r-00000`):

```
0528881469	2.4
0594451647	4.2
0594481813	4.0
0972683275	4.390243902439025
```

## Построение `jar` файла на `maven`

Перейдите в maven panel, найдите `Plugins` folder -> `jar` -> `jar:jar`. После компиляции актуальный `jar` файл размещается в target директории.

Вы можете построить `jar` файл при помощи Scala [например](../projects/scala/mapreduce_scala.md).


## Выполнение MapReduce `jar` файла на YARN-кластере

#### Запуск Hadoop-кластера

Запуск `HDFS`:

`$HADOOP_HOME/sbin/start-dfs.sh`

Запуск `YARN`:

`$HADOOP_HOME/sbin/start-yarn.sh`

Запуск Job History Server:

`mapred --daemon start historyserver`

Или всё одной командой:

`$HADOOP_HOME/sbin/start-dfs.sh && $HADOOP_HOME/sbin/start-yarn.sh && mapred --daemon start historyserver`

Проверьте запуск всех служб:

`jps`

#### Запуск приложения:

Удалите при необходимости выходную директорию:

`hdfs dfs -rm -r -f /data/yarn/output`

Запустите задание:

`yarn jar /PATH/YOUR-app-1.1.jar -D mapreduce.job.reduces=2 /PATH_to_DATA/YOUR_DATA.json /data/yarn/output`
