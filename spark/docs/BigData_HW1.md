# ДОМАШНЕЕ ЗАДАНИЕ 1. Spark RDD API



### Содержание

- [Задание 1](#Задание-1)
- [Задание 2](#Задание-2)
- [Задание 3](#Задание-3)

⚠️ **Замечание**: используйте только стандартные операции `RDD` `API`

## **Задание 1**

[Набор данных](../data/places.csv)

```python
# Наименование столбцов
['ID', 'Name', 'global_id', 'IsNetObject', 'OperatingCompany', 'TypeObject', 'AdmArea', 'District', 'Address', 'PublicPhone', 'SeatsCount', 'SocialPrivileges', 'Longitude_WGS84', 'Latitude_WGS84', 'geoData']
```

⚠️ **Замечание**: 1) для парсинга данных используйте модуль `csv`; 2) для вычисления расстояния используйте формулу гаверсинуса.

1. Рассчитайте расстояние от заданной точки (`lat=55.751244`, `lng=37.618423`) до каждого заведения общепита из набора данных. Выведите первые 10. 
2. Рассчитайте расстояние между всеми заведениями общепита из набора данных. Выведите первые 10.
3. Выведите топ-10 наиболее близких и наиболее отдаленных заведений.

## **Задание 2**

Набор данных: [описание](http://jmcauley.ucsd.edu/data/amazon/links.html), [отзывы](http://snap.stanford.edu/data/amazon/productGraph/categoryFiles/reviews_Electronics_5.json.gz), [товары](http://snap.stanford.edu/data/amazon/productGraph/categoryFiles/meta_Electronics.json.gz)

⚠️ **Замечание**: для парсинга товаров используйте функцию `eval`.

1. Рассчитайте средний рейтинг товаров из набора данных. 
2. Сопоставьте полученные данные из предыдущего пункта с наименованием товаров.
3. Сформируйте RDD товаров с рейтингом меньшим 3. Выведите топ-10 товаров с наименьшим рейтингом.
4. Сохраните результат в постоянное хранилище.

Ниже ссылка (в соответствии с политикой использования набора данных): 
- Ups and downs: Modeling the visual evolution of fashion trends with one-class collaborative filtering
R. He, J. McAuley
WWW, 2016

## **Задание 3**

[Набор данных](http://files.grouplens.org/datasets/movielens/ml-latest-small.zip)

1. Вычислите косинусное сходство между рейтингами фильмов.
2. Для фильма с `movieId` равным `589` сформируйте RDD со значениями сходства с остальными фильмами
3. Добавьте наименования фильмов.
2. Выведите топ-10 наиболее похожих фильмов.

ℹ️ Пример расчета посредством `SQL` (без нормализации):
```sql
SELECT r1.prodId, r2.prodId, SUM(r1.val * r2.val) AS sim
FROM rating AS r1 JOIN rating AS r2 ON r1.userId = r2.userId
WHERE r1.prodId < r2.prodId
GROUP BY r1.prodId, r2.prodId
```