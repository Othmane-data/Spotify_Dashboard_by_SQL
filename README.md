# Spotify Dashboard Project and Query Data Analysis by SQL

![](Spotify.png)
--


## Introduction
This project involves analyzing a Spotify dataset with various attributes about tracks, albums, and artists using SQL. It covers an end-to-end process of normalizing a denormalized dataset, performing SQL queries of varying complexity (easy, medium, and advanced), and optimizing query performance. The primary goals of the project are to practice advanced SQL skills and generate valuable insights from the dataset.

## Table creation

```sql
-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);
```

## Practice Questions


### Easy Level

__Retrieve the names of all tracks that have more than 1 billion streams.__

```sql
Select
 *
 from spotify
where stream > 1000000000
```

__List all albums along with their respective artists.__

```sql
select 
distinct album,
artist
from spotify
```

__Get the total number of comments for tracks where licensed = TRUE.__

```sql
select 
track,
comments
from spotify
where licensed = TRUE
```

__Find all tracks that belong to the album type single.__

select *
from spotify
where 
album_type = 'single'
```

__Count the total number of tracks by each artist.__


```sql
Select
 artist,
count(track) as total_track
from 
spotify
group by 1
order by 2 desc
```


### Medium Level

__Calculate the average danceability of tracks in each album.__

```sql
select 
album,
avg(danceability) as avg_denceabilty
from 
spotify
group by 1
order by 2 desc
```

__Find the top 5 tracks with the highest energy values.__

```sql
select * 
from 
spotify
order by energy desc
limit 5
```

__List all tracks along with their views and likes where official_video = TRUE.__

```sql
select 
track,
sum(views)as total_views,
sum(likes) as total_likes
from 
spotify
where official_video = TRUE
group by track
order by 2 desc
```

__For each album, calculate the total views of all associated tracks.__

```sql
select 
distinct album,
sum(views) as total_views
from spotify
group by 1
order by 2 desc
```

__Retrieve the track names that have been streamed on Spotify more than YouTube.__

```sql
select * 
from
(SELECT track,
Coalesce
(sum(case when most_played_on ='Youtube'then stream end),0) as stream_on_youtube,
Coalesce
(sum(case when most_played_on ='Spotify'then stream end),0) as stream_on_spotify
from spotify
group by 1
) as table_1
where table_1.stream_on_spotify > table_1.stream_on_youtube
and stream_on_youtube <> 0
```


### Advanced Level

__Find the top 3 most-viewed tracks for each artist using window functions.__

```sql
Select
 artist,
sum(views)
from 
spotify
group by 1
order by 2 desc
```

__Write a query to find tracks where the liveness score is above the average.__

```sql
select 
track,
artist,
liveness
from spotify
where
 liveness > (select avg (liveness) from spotify)
order by 3 desc
```

__Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.__

```sql
with energy_Table as
 (
select album,
max(energy) as hight_energy,
min(energy) as lowest_energy
from spotify
group by 1
)
select 
album,
(energy_Table.hight_energy - energy_Table.lowest_energy) as difference
from 
energy_Table
order by 2 desc
```
