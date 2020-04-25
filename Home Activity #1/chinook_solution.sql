SELECT
	artist.Name as artist_name,
    album.Title as album_title,
    genre.Name as genre,
    SUM(invoiceline.Quantity) as tracks_sold,
     invoiceline.UnitPrice as price_per_track,
    (SUM(invoiceline.Quantity) * invoiceline.UnitPrice) as total_sales,
    SUM(playlist_agg.playlists_count) as playlists_involved,
    CASE
    	WHEN SUM(playlist_agg.playlists_count) > 50 THEN 'Very Popular'
    	WHEN SUM(playlist_agg.playlists_count) BETWEEN 26 AND 50 THEN 'Popular'
        WHEN SUM(playlist_agg.playlists_count) BETWEEN 10 AND 25 THEN 'Gaining traction'
        ELSE 'Not Popular'
    END as popularity
FROM artist
JOIN album USING (ArtistID)
JOIN track USING (AlbumId)
JOIN genre USING (GenreId)
JOIN invoiceline USING(TrackId)
JOIN (
    SELECT
	TrackID,
	COUNT(TrackId) as playlists_count
FROM `playlisttrack`
GROUP BY TrackId
) as playlist_agg USING (TrackId)
GROUP BY AlbumID
