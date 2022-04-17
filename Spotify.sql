create database Spotify
use Spotify

--Artists table:
create table Artists
(
	Id int primary key Identity(1,1),
	[Name] nvarchar(30) not null,
)

--Albums table:
create table Albums
(
	Id int primary key Identity(1,1),
	[Name] nvarchar(30),
	NumberOfMusic int default 0 ,
	ArtistId int foreign key references Artists(Id) not null
)

--Musics table:
create table Musics
(
	Id int primary key Identity(1,1),
	[Name] nvarchar(30) not null,
	TotalSecond int not null,
	IsDeleted bit default 0,
	ListenerCount int default 0,
	AlbumId int foreign key references Albums(Id) not null
)
Update Musics set ListenerCount = 0
------------------------Inserts---------------------------
Insert into Artists values ('Ed Sheeren'),('Ariana Grande'),('Drake'),
('Billie Eilish'),('Justin Bieber'),('Eminem'),('Taylor Swift'),('Rihanna'),
('Bad Bunny'),('Arijit Singh'),('The Weeknd'),('Queen'),('Bruno Mars')
Insert into Albums ([Name],ArtistId) values ('Divide',1),('The Orange',1),('Want Some?',1),('Loose Change',1), ('Yo need me',1)
Insert into Albums ([Name],ArtistId) values ('Positions',2),('Dangerous Woman',2),('Yours Truly',2),('The Best',2)
Insert into Albums ([Name],ArtistId) values ('Scorpion',3),('Take Care',3),('Views',3),('Thank Me Later',3), ('What a Time to be Alive',3),('Nothing was the same',3)
Insert into Albums ([Name],ArtistId) values ('Happier Than Ever',4), ('Live at Third Man Records',4), ('Do Not Smile at Me',4), ('When We All Fall Asleep',4)
Insert into Albums ([Name],ArtistId) values ('Justice',5), ('Changes',5), ('My World 2.0',5), ('Believe',5), ('Purpose',5)
Insert into Albums ([Name],ArtistId) values ('The Marshall Mathers LP',6), ('The Eminem Show',6), ('Kamikaze',6), ('Recovery',6), ('Encore',6), ('The Slim Shady LP',6)
Insert into Albums ([Name],ArtistId) values ('Folklore',7), ('Evermore',7), ('Fearless',7), ('Red',7), ('Speak Now',7)
Insert into Albums ([Name],ArtistId) values ('Anti',8),('Loud',8),('Talk That Talk',8),('Music of the Sun',8),('Rated R',8),('Good Girl Gone Bad',8)
Insert into Albums ([Name],ArtistId) values ('El Bano',9),('Oasis',9), ('El Conejo Malo',9), ('El Ultimo Tour Der Mundo',9), ('Las que no iban a salir',9)
Insert into Albums ([Name],ArtistId) values ('Tamasha',10), ('Ae Dil Hai Mushkil',11), ('Ultimate love',10)
Insert into Albums ([Name],ArtistId) values ('Dawn FM',11), ('After Hours',11), ('Starboy',11), ('House of Balloons',11), ('Echoes of Silence',11), ('Kiss Land',11)
Insert into Albums ([Name],ArtistId) values ('Innuendo',12), ('A Night at the Opera',12), ('Sheer Heart Attack',12), ('A kind of Magic',12), ('Made in Heaven',12)
Insert into Albums ([Name],ArtistId) values ('24k Magic',13), ('The Lost Planet',13), ('Unorthodox jukebox',13), ('The Grenade Sessions',13)

Insert into Musics ([Name], TotalSecond, AlbumId) values('Dive',359,1)
Insert into Musics ([Name], TotalSecond, AlbumId) values('Perfect',423,1)
Insert into Musics ([Name], TotalSecond, AlbumId) values('Castle on the Hill',421,1)
Insert into Musics ([Name], TotalSecond, AlbumId) values('Shape Of You',354,1)

Insert into Musics ([Name], TotalSecond, AlbumId) values('moody Ballad Of Ed',354,2)
Insert into Musics ([Name], TotalSecond, AlbumId) values('Typical Average',243,2)
Insert into Musics ([Name], TotalSecond, AlbumId) values('I love you',531,2)
Insert into Musics ([Name], TotalSecond, AlbumId) values('Misery',154,2)

Insert into Musics ([Name], TotalSecond, AlbumId) values('You Break Me',314,3)
Insert into Musics ([Name], TotalSecond, AlbumId) values('You need to Cut Your Hair',343,3)
Insert into Musics ([Name], TotalSecond, AlbumId) values('Move on',231,3)
Insert into Musics ([Name], TotalSecond, AlbumId) values('I am Glad I am Not You',154,3)
----------------------------------------------------------
Create trigger IncreaseMusicNumber 
on Musics
after insert
as
begin
	Update Albums set NumberOfMusic = NumberOfMusic+1 where Id = (Select AlbumId from inserted Musics) 
end


create trigger InsteadOfDelete
on Musics
Instead of delete
as
begin
	Update Musics set IsDeleted = 1 where Id = (Select Id from deleted Musics)
end


create view GetMusicInfo
as
Select Musics.[Name] as 'Music', TotalSecond as 'Duration', Albums.[Name] as 'Album', Artists.[Name] as 'Artist' from Musics 
join Albums 
on Musics.AlbumId = Albums.Id 
join Artists
on Albums.ArtistId = Artists.Id


create view GetAlbumInfo
as
Select Albums.[Name] as 'Album',NumberOfMusic as 'Number of Music', Artists.[Name] as 'Artist' from Albums join Artists on ArtistId = Artists.Id

----------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
create procedure GetMusicNames (@ListenerCount int ,@Search nvarchar)
as
Select Musics.[Name] 'Music' ,ListenerCount 'Number Of Listeners', Albums.[Name] 'Album' from Musics 
join Albums
on AlbumId = Albums.Id 
where ListenerCount> @ListenerCount And Charindex(@Search, Musics.[name]) > 0
------------------------------------------------------------------------------------------


--Using 'GetMucisName' procedure--
exec GetMusicNames 53145, 's'

--Using 'InsteadOfDelete' trigger--
Delete from Musics where Id = 15
Select * from Musics where Id = 15 --From Now, isDeleted is 1 which means it is true

--Using Views written above--
Select * from GetAlbumInfo
Select * from GetMusicInfo
