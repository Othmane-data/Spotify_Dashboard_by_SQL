-- ------------------------
--15 Practice Questions
-- ------------------------
--Easy Level
-- ----------------------------------------------------------
--Retrieve the names of all tracks that have more than 1 billion streams.

SELECT * from spotify
where stream > 1000000000

--List all albums along with their respective artists.

select distinct album,
artist
from spotify

--Get the total number of comments for tracks where licensed = TRUE.

select track,
comments
from spotify
where licensed = TRUE

--Find all tracks that belong to the album type single.

select * from spotify
where album_type = 'single'

--Count the total number of tracks by each artist.

select artist,
count(track) as total_track
from spotify
group by 1
order by 2 desc

-- ----------------------------------------
--Medium Level
-- -------------------------------------------
--Calculate the average danceability of tracks in each album.

select album,
avg(danceability) as avg_denceabilty
from spotify
group by 1
order by 2 desc
--Find the top 5 tracks with the highest energy values.

select * from spotify
order by energy desc
limit 5

--List all tracks along with their views and likes where official_video = TRUE.

select track,
sum(views)as total_views,
sum(likes) as total_likes
from spotify
where official_video = TRUE
group by track
order by 2 desc

--For each album, calculate the total views of all associated tracks.

select distinct album,
sum(views) as total_views
from spotify
group by 1
order by 2 desc

--Retrieve the track names that have been streamed on Spotify more than YouTube.

select * from
(SELECT track,
coalesce(sum(case when most_played_on ='Youtube'then stream end),0) as stream_on_youtube,
coalesce(sum(case when most_played_on ='Spotify'then stream end),0) as stream_on_spotify
from spotify
group by 1
) as table_1
where table_1.stream_on_spotify > table_1.stream_on_youtube
and stream_on_youtube <> 0


-- -----------------------------------------
--Advanced Level
-- ---------------------------------------------
--Find the top 3 most-viewed tracks for each artist using window functions.

select artist,
sum(views)
from spotify
group by 1
order by 2 desc

--Write a query to find tracks where the liveness score is above the average.

select track,
artist,
liveness
from spotify
where liveness > (select avg (liveness) from spotify)
order by 3 desc

--Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
with energy_Table as (
select album,
max(energy) as hight_energy,
min(energy) as lowest_energy
from spotify
group by 1
)
select album,
(energy_Table.hight_energy - energy_Table.lowest_energy) as difference
from energy_Table
order by 2 desc


