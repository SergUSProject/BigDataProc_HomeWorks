# MapReduce и Python
## Содержание:

- [Инструменты](#Инструменты)
- [Установка `Python` plugin для `IntelliJ`](#Установка-`Python`-plugin-для-`IntelliJ`)
- [Создание `Python`-проекта](#Создание-`Python`-проекта)
- [Пример исходного кода](#Пример-исходного-кода)
- [Запуск MapReduce с локальными файлами](#Запуск-MapReduce-с-локальными-файлами)
- [Запуск MapReduce `python`-приложения на YARN-кластере](#Запуск-MapReduce-`python`-приложения-на-YARN-кластере)

## Инструменты

Для запуска необходимы следующие инструменты:

- Ubuntu 14+ (with Python 3.x)
- Java 8
- Hadoop 3+
- (Optional) IntelliJ 2019+ (for Python code)
- (Optional) PyCharm 2019+ (for Python code)
- (Optional) Jupyter Notebook

## Установка `Python` plugin для `IntelliJ`

`File` -> `Settings` -> `Plugins` -> Найдите `Python Community Edition` plugin для `JetBrains` -> Нажмите `Install` -> Restart IDE

## Создание `Python` -проекта

`File` -> `New` -> `Project...` -> `Python` -> Next ->  Name: `wordcountapp` - > Finish

## Пример исходного кода

Mapper

[tokenizer_mapper.py](./wordcountapp/tokenizer_mapper.py)

Combiner/Reducer

[intsum_reducer.py](./wordcountapp/intsum_reducer.py)

## Запуск MapReduce с локальными файлами

Запустите mapper на малом простом текстовом файле и посмотрите на результат:

`cat /PATH_to_DATA/YOUR_DATA.json | python tokenizer_mapper.py`

Входные данные для reducer должны быть упорядочены. Так `hadoop-streaming` сортирует кортежи, полученные на шаге map по ключу.

`cat /PATH_to_DATA/YOUR_DATA.json | python tokenizer_mapper.py | sort`

Запустите map-reduce pipeline целиком:

`cat /PATH_to_DATA/YOUR_DATA.json | python tokenizer_mapper.py | sort | python intsum_reducer.py`

## Запуск MapReduce `python` -приложения на YARN-кластере

```
yarn jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.1.2.jar \
    -D mapreduce.job.reduces=2 \
    -mapper "python /PATH/py/wordcountapp/tokenizer_mapper.py/tokenizer_mapper.py" \
    -reducer "python /PATH/py/wordcountapp/intsum_reducer.py" \
    -input "/data/yarn/reviews_Electronics_5_2.json" \
    -output "/data/yarn/output"
```
