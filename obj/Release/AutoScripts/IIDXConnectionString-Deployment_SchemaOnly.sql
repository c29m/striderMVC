CREATE USER [TEKKA\ASPNET] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [NT AUTHORITY\NETWORK SERVICE] FOR LOGIN [NT AUTHORITY\NETWORK SERVICE] WITH DEFAULT_SCHEMA=[dbo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Styles](
	[StyleID] [int] IDENTITY(1,1) NOT NULL,
	[StyleOrder] [int] NULL,
	[StyleName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Theme] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ParentID] [int] NULL,
 CONSTRAINT [PK_Styles] PRIMARY KEY CLUSTERED 
(
	[StyleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Modes](
	[ModeID] [int] IDENTITY(1,1) NOT NULL,
	[Mode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Abbr] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Modes] PRIMARY KEY CLUSTERED 
(
	[ModeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE FUNCTION [dbo].[IIDXGrade] (@TotalNotes int, @EXScore int)  
RETURNS varchar(3) AS  
BEGIN 
	DECLARE @retVal varchar(3)
	DECLARE @tn int, @ex int
	DECLARE @E int, @D int, @C int, @B int, @A int, @AA int, @AAA int

	SET @tn=@TotalNotes
	SET @ex=@EXScore
	
	SET @AAA = ((@tn * 2) * 8) / 9
	SET @AA  = ((@tn * 2) * 7) / 9
	SET @A   = ((@tn * 2) * 6) / 9
	SET @B   = ((@tn * 2) * 5) / 9
	SET @C   = ((@tn * 2) * 4) / 9
	SET @D   = ((@tn * 2) * 3) / 9
	SET @E   = ((@tn * 2) * 2) / 9
	
	IF @ex >= @AAA SET @retVal = 'AAA'
	IF @ex >= @AA AND @ex < @AAA SET @retVal = 'AA'
	IF @ex >= @A AND @ex < @AA SET @retVal   = 'A'
	IF @ex >= @B AND @ex < @A SET @retVal    = 'B'
	IF @ex >= @C AND @ex < @B SET @retVal    = 'C'
	IF @ex >= @D AND @ex < @C SET @retVal    = 'D'
	IF @ex >= @E AND @ex < @D SET @retVal    = 'E'
	IF @ex < @E SET @retVal = 'F'

	IF @retVal IS NULL SET @retVal = '???'

	RETURN @retVal
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DJs](
	[DJID] [int] IDENTITY(1,1) NOT NULL,
	[DJName] [varchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Password] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Info] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_DJs] PRIMARY KEY CLUSTERED 
(
	[DJID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SongInfo](
	[SongInfoID] [int] IDENTITY(1,1) NOT NULL,
	[StyleID] [int] NOT NULL,
	[Title] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Genre] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Artist] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BPM] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Notes] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_SongInfo] PRIMARY KEY CLUSTERED 
(
	[SongInfoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Michael D. Tighe <strider->
-- Create date: 8/29/2006 (SQL 2005 version)
-- Description:	
-- =============================================
CREATE PROCEDURE dbo.spOverallPerformance
	@DJID int
AS
	SELECT 
	Sum(TotalNotes) AS TotalNotes,
	Sum(EXScore) AS EXScore,
	Avg(Accuracy) AS Accuracy,
	dbo.IIDXGrade(Sum(TotalNotes), Sum(EXScore)) AS Grade
	FROM vwDJScores 
	WHERE DJID = @DJID


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael D. Tighe <strider->
-- Create date: 8/29/2006 (SQL 2005 version)
-- Description:	
-- =============================================
CREATE PROCEDURE dbo.spAddDJ
	@DJName varchar(6),
	@Password varchar(50),
	@Info varchar(200)
AS
	IF EXISTS(SELECT UPPER(DJName) FROM DJs WHERE DJName=UPPER(@DJName))
	BEGIN
		RAISERROR ('Sorry, the DJ Name "%s" is already in use.', 16, 1, @DJName)
		RETURN -1
	END
	ELSE
	BEGIN
		INSERT INTO DJs (DJName, [Password], Info) VALUES (@DJName, @Password, @Info)
		RETURN @@IDENTITY
	END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.vwStyles
AS
SELECT     dbo.Styles.*
FROM         dbo.Styles
UNION
SELECT     0, 0, 'All Songs', '', null

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Michael D. Tighe <strider->
-- Create date: 8/29/2006 (SQL 2005 version)
-- Description:	
-- =============================================
CREATE PROCEDURE dbo.spAddNewSong
	@StyleID int,
	@Title nvarchar(100),
	@Genre nvarchar(50),
	@Artist nvarchar(100),
	@BPM varchar(50),
	@Info nvarchar(100)
AS

	
	IF EXISTS (SELECT * FROM SongInfo WHERE StyleID=@StyleID AND Title=@Title)
	BEGIN
		DECLARE @Style varchar(100)
		SELECT @Style = StyleName FROM Styles WHERE StyleID = @StyleID
		RAISERROR('The song "%s" already exists under %s!', 16, 1, @Title, @Style)
		RETURN -1
	END
	ELSE
	BEGIN
		INSERT INTO SongInfo (StyleID, Title, Genre, Artist, BPM, Notes) VALUES
		(@StyleID, @Title, @Genre, @Artist, @BPM, @Info)
		RETURN @@IDENTITY
	END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Michael D. Tighe <strider->
-- Create date: 8/29/2006 (SQL 2005 version)
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spEditSongInfo]
	@SongInfoID int,
	@StyleID int,
	@Title nvarchar(100),
	@Genre nvarchar(50),
	@Artist nvarchar(100),
	@BPM varchar(50),
	@Info nvarchar(100)
AS
	UPDATE SongInfo 
	SET
		StyleID = @StyleID,
		Title = @Title,
		Genre = @Genre,
		Artist = @Artist,
		BPM = @BPM,
		Notes = @Info
	WHERE
		SongInfoID = @SongInfoID
		

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Songs](
	[SongID] [int] IDENTITY(1,1) NOT NULL,
	[ModeID] [int] NOT NULL,
	[SongInfoID] [int] NOT NULL,
	[TotalNotes] [int] NOT NULL,
	[Difficulty] [int] NOT NULL,
 CONSTRAINT [PK_Songs] PRIMARY KEY CLUSTERED 
(
	[SongID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CSRevivals](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SongInfoID] [int] NOT NULL,
	[StyleID] [int] NOT NULL,
 CONSTRAINT [PK_CSRevivals] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Scores](
	[ScoreID] [int] IDENTITY(1,1) NOT NULL,
	[DJID] [int] NOT NULL,
	[SongID] [int] NOT NULL,
	[EXScore] [int] NOT NULL,
	[ArcadeScore] [int] NULL,
	[Stamp] [datetime] NOT NULL,
 CONSTRAINT [PK_Scores] PRIMARY KEY CLUSTERED 
(
	[ScoreID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Michael D. Tighe <strider->
-- Create date: 8/29/2006 (SQL 2005 version)
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spGetSongRecords] 
	@SongID int
AS
	DECLARE @SongInfoID int
	
	SELECT @SongInfoID = SongInfoID FROM Songs WHERE SongID = @SongID
	
	SELECT * FROM SongInfo WHERE SongInfoID = @SongInfoID
	SELECT * FROM Songs WHERE SongInfoID = @SongInfoID


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Michael D. Tighe <strider->
-- Create date: 8/29/2006 (SQL 2005 version)
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spGetGradeScale]
	@SongID int
AS
	DECLARE @tn int
	DECLARE @E int, @D int, @C int, @B int, @A int, @AA int, @AAA int

	SELECT @tn = TotalNotes FROM Songs WHERE SongID = @SongID
	
	SET @AAA = ((@tn * 2) * 8) / 9
	SET @AA   = ((@tn * 2) * 7) / 9
	SET @A     = ((@tn * 2) * 6) / 9
	SET @B     = ((@tn * 2) * 5) / 9
	SET @C     = ((@tn * 2) * 4) / 9
	SET @D     = ((@tn * 2) * 3) / 9
	SET @E     = ((@tn * 2) * 2) / 9

	SELECT @AAA AAA,@AA AA,@A A,@B B,@C C,@D D,@E E

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Michael D. Tighe <strider->
-- Create date: 8/29/2006 (SQL 2005 version)
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spEditSong]
	@SongID int,
	@TotalNotes int,
	@Difficulty nvarchar(50)
AS
	UPDATE Songs
	SET
		TotalNotes = @TotalNotes,
		Difficulty = @Difficulty		
	WHERE SongID = @SongID		

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Michael D. Tighe <strider->
-- Create date: 8/29/2006 (SQL 2005 version)
-- Description:	
-- =============================================
CREATE PROCEDURE dbo.spAddNewSongMode
	@ModeID int,
	@SongInfoID int,
	@TotalNotes int,
	@Difficulty nvarchar(50)
AS
	IF EXISTS(SELECT * FROM Songs WHERE ModeID=@ModeID AND SongInfoID=@SongInfoID)
	BEGIN
		DECLARE @Song nvarchar(100)
		DECLARE @Mode varchar(20)
		DECLARE @Message varchar(200)

		SELECT @Song=Title FROM SongInfo WHERE SongInfoID=@SongInfoID
		SELECT @Mode=Mode FROM Modes WHERE ModeID=@ModeID
		SET @Message = 'Song information for the given values exists. (' + @Song + ' ' + @Mode + ')'

		RAISERROR (@Message, 16, 1)
		RETURN -1
	END
	ELSE
	BEGIN
		INSERT INTO Songs (ModeID, SongInfoID, TotalNotes, Difficulty) VALUES (@ModeID, @SongInfoID, @TotalNotes, @Difficulty)
		RETURN @@IDENTITY
	END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.vwSongs
AS
SELECT     dbo.Songs.SongID, dbo.Styles.StyleID, dbo.SongInfo.Title, dbo.SongInfo.Artist, dbo.SongInfo.Genre, dbo.Modes.ModeID, dbo.Songs.TotalNotes, 
                      dbo.SongInfo.BPM, dbo.Songs.Difficulty, dbo.SongInfo.Notes
FROM         dbo.Songs INNER JOIN
                      dbo.SongInfo ON dbo.Songs.SongInfoID = dbo.SongInfo.SongInfoID INNER JOIN
                      dbo.Styles ON dbo.SongInfo.StyleID = dbo.Styles.StyleID INNER JOIN
                      dbo.Modes ON dbo.Modes.ModeID = dbo.Songs.ModeID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.vwScores
AS
SELECT     TOP (100) PERCENT d.DJName, si.Title, m.Abbr, so.Difficulty, sc.EXScore, dbo.IIDXGrade(so.TotalNotes, sc.EXScore) AS Grade, CONVERT(decimal(10), 
                      sc.EXScore) / CONVERT(decimal(10), so.TotalNotes * 2) AS Accuracy, sc.Stamp, d.DJID, sc.ScoreID, so.SongID, si.SongInfoID, m.ModeID, 
                      st.StyleID
FROM         dbo.Scores AS sc INNER JOIN
                      dbo.DJs AS d ON sc.DJID = d.DJID INNER JOIN
                      dbo.Songs AS so ON so.SongID = sc.SongID INNER JOIN
                      dbo.SongInfo AS si ON si.SongInfoID = so.SongInfoID INNER JOIN
                      dbo.Modes AS m ON m.ModeID = so.ModeID INNER JOIN
                      dbo.Styles AS st ON st.StyleID = si.StyleID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Michael D. Tighe <strider->
-- Create date: 8/29/2006 (SQL 2005 version)
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spAddNewScore] 
	@DJID int,
	@SongID int,
	@EXScore int,
	@ArcadeScore int
AS
	IF(@ArcadeScore=0)
		INSERT INTO Scores (DJID, SongID, EXScore) VALUES (@DJID, @SongID, @EXScore)
	ELSE
		INSERT INTO Scores (DJID, SongID, EXScore, ArcadeScore) VALUES (@DJID, @SongID, @EXScore, @ArcadeScore)



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Michael D. Tighe <strider->
-- Create date: 8/29/2006 (SQL 2005 version)
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spGetSongList]
	@ModeID int,
	@StyleID int,
	@Difficulty varchar(3)
AS
	IF (@StyleID = 0)
		IF (@Difficulty = '%')
			SELECT * FROM vwSongs WHERE
			ModeID = @ModeID AND
			StyleID > @StyleID AND
			Difficulty LIKE @Difficulty
			ORDER BY Title
		ELSE
			SELECT * FROM vwSongs WHERE
			ModeID = @ModeID AND
			StyleID > @StyleID AND
			Difficulty = @Difficulty
			ORDER BY Len(Difficulty), Difficulty, Title
	ELSE
		IF (@Difficulty = '%')
			SELECT * FROM vwSongs WHERE
			ModeID = @ModeID AND
			StyleID = @StyleID AND
			Difficulty LIKE @Difficulty
			ORDER BY Len(Difficulty), Difficulty, Title
		ELSE
			SELECT * FROM vwSongs WHERE
			ModeID = @ModeID AND
			StyleID = @StyleID AND
			Difficulty = @Difficulty
			ORDER BY Len(Difficulty), Difficulty, Title


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Michael D. Tighe <strider->
-- Create date: 8/29/2006 (SQL 2005 version)
-- Description:	
-- =============================================
CREATE PROCEDURE dbo.spGetSongInfo
	@SongID int
AS	
	SELECT Styles.StyleName, vwSongs.Title, vwSongs.Notes
	FROM vwSongs
	JOIN Styles ON Styles.StyleID = vwSongs.StyleID 
	WHERE SongID=@SongID



GO
ALTER TABLE [dbo].[Styles] ADD  CONSTRAINT [DF_Styles_Theme]  DEFAULT ('') FOR [Theme]
GO
ALTER TABLE [dbo].[Modes] ADD  CONSTRAINT [DF_Modes_Abbr]  DEFAULT ('') FOR [Abbr]
GO
ALTER TABLE [dbo].[DJs] ADD  CONSTRAINT [DF_DJs_Password]  DEFAULT ('') FOR [Password]
GO
ALTER TABLE [dbo].[DJs] ADD  CONSTRAINT [DF_DJs_Info]  DEFAULT ('') FOR [Info]
GO
ALTER TABLE [dbo].[SongInfo]  WITH CHECK ADD  CONSTRAINT [FK_SongInfo_Styles] FOREIGN KEY([StyleID])
REFERENCES [dbo].[Styles] ([StyleID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SongInfo] CHECK CONSTRAINT [FK_SongInfo_Styles]
GO
ALTER TABLE [dbo].[SongInfo] ADD  CONSTRAINT [DF_SongInfo_Notes]  DEFAULT ('') FOR [Notes]
GO
ALTER TABLE [dbo].[Songs]  WITH CHECK ADD  CONSTRAINT [FK_Songs_Modes] FOREIGN KEY([ModeID])
REFERENCES [dbo].[Modes] ([ModeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Songs] CHECK CONSTRAINT [FK_Songs_Modes]
GO
ALTER TABLE [dbo].[Songs]  WITH CHECK ADD  CONSTRAINT [FK_Songs_SongInfo] FOREIGN KEY([SongInfoID])
REFERENCES [dbo].[SongInfo] ([SongInfoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Songs] CHECK CONSTRAINT [FK_Songs_SongInfo]
GO
ALTER TABLE [dbo].[Songs] ADD  CONSTRAINT [DF_Songs_Difficulty2]  DEFAULT ((0)) FOR [Difficulty]
GO
ALTER TABLE [dbo].[CSRevivals]  WITH CHECK ADD  CONSTRAINT [FK_CSRevivals_SongInfo] FOREIGN KEY([SongInfoID])
REFERENCES [dbo].[SongInfo] ([SongInfoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CSRevivals] CHECK CONSTRAINT [FK_CSRevivals_SongInfo]
GO
ALTER TABLE [dbo].[CSRevivals]  WITH CHECK ADD  CONSTRAINT [FK_CSRevivals_Styles] FOREIGN KEY([StyleID])
REFERENCES [dbo].[Styles] ([StyleID])
GO
ALTER TABLE [dbo].[CSRevivals] CHECK CONSTRAINT [FK_CSRevivals_Styles]
GO
ALTER TABLE [dbo].[Scores]  WITH CHECK ADD  CONSTRAINT [FK_Scores_DJs] FOREIGN KEY([DJID])
REFERENCES [dbo].[DJs] ([DJID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Scores] CHECK CONSTRAINT [FK_Scores_DJs]
GO
ALTER TABLE [dbo].[Scores]  WITH CHECK ADD  CONSTRAINT [FK_Scores_Songs] FOREIGN KEY([SongID])
REFERENCES [dbo].[Songs] ([SongID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Scores] CHECK CONSTRAINT [FK_Scores_Songs]
GO
ALTER TABLE [dbo].[Scores] ADD  CONSTRAINT [DF_Scores_Stamp]  DEFAULT (getdate()) FOR [Stamp]
GO
