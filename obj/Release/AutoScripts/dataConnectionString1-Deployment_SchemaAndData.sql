SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Summary] [nvarchar](200) COLLATE Latin1_General_CI_AS NOT NULL,
	[Progress] [float] NOT NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET IDENTITY_INSERT [dbo].[Projects] ON 

GO
INSERT [dbo].[Projects] ([ID], [Title], [Summary], [Progress]) VALUES (1, N'NFO Style CMS', N'My old blog. A blog that looks like an old school NFO. Check out that custom ASCII progress bar. The .01% left is for bug fixes & last-minute changes, and random additions.', 0.9999)
GO
INSERT [dbo].[Projects] ([ID], [Title], [Summary], [Progress]) VALUES (2, N'WPF IIDX Frontend', N'Learning WPF through rebuilding my IIDX score keeping front end. No adding/editing records though, purely for viewing.', 1)
GO
INSERT [dbo].[Projects] ([ID], [Title], [Summary], [Progress]) VALUES (3, N'ImgChan', N'Download all the images from a *chan thread. I want to learn how to make Firefox extensions, this would be a great candidate.', 1)
GO
INSERT [dbo].[Projects] ([ID], [Title], [Summary], [Progress]) VALUES (4, N'Rush Hour', N'Learning the ins and outs of XNA 3.0 by writing my own implementation of Rush Hour (Gridlock''d), complete with level editor. XNA is the shit BTW.', 1)
GO
INSERT [dbo].[Projects] ([ID], [Title], [Summary], [Progress]) VALUES (6, N'MVC Style CMS', N'This blog, learning more about Microsoft''s take on MVC development, which thus far rules.  I got beef with Entity Framework though...', 0.85)
GO
SET IDENTITY_INSERT [dbo].[Projects] OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Headers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[header] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
 CONSTRAINT [PK_Headers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET IDENTITY_INSERT [dbo].[Headers] ON 

GO
INSERT [dbo].[Headers] ([id], [header]) VALUES (1, N'warez mad warez')
GO
INSERT [dbo].[Headers] ([id], [header]) VALUES (2, N'respect to the man in the ice cream van')
GO
INSERT [dbo].[Headers] ([id], [header]) VALUES (3, N'I gave my love a chicken, it had no bones')
GO
INSERT [dbo].[Headers] ([id], [header]) VALUES (4, N'they think I''m ridin'' QWERTY')
GO
INSERT [dbo].[Headers] ([id], [header]) VALUES (5, N'bits please')
GO
INSERT [dbo].[Headers] ([id], [header]) VALUES (6, N'0xABADBABE')
GO
INSERT [dbo].[Headers] ([id], [header]) VALUES (7, N'u mad')
GO
INSERT [dbo].[Headers] ([id], [header]) VALUES (8, N'cp /dev/null/ ~')
GO
INSERT [dbo].[Headers] ([id], [header]) VALUES (9, N'deal with it')
GO
INSERT [dbo].[Headers] ([id], [header]) VALUES (10, N'0xDEADBEEF')
GO
SET IDENTITY_INSERT [dbo].[Headers] OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Author] [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Published] [datetime] NOT NULL,
	[Modified] [datetime] NULL,
	[Title] [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
	[Text] [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
	[Mobile] [bit] NOT NULL,
	[Slug] [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)

GO
SET IDENTITY_INSERT [dbo].[Posts] ON 

GO
INSERT [dbo].[Posts] ([ID], [Author], [Published], [Modified], [Title], [Text], [Mobile], [Slug]) VALUES (2, N'strider-', CAST(0x00009D6B00E3F760 AS DateTime), CAST(0x00009D6B00E6B680 AS DateTime), N'Test Post', N'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 0, N'Test-Post')
GO
INSERT [dbo].[Posts] ([ID], [Author], [Published], [Modified], [Title], [Text], [Mobile], [Slug]) VALUES (9, N'strider-', CAST(0x00009D6B0100DCFF AS DateTime), CAST(0x00009D6B0184BAA1 AS DateTime), N'IIDX GOOOOOOOOOLD', N'MAKE IT MAKE MONEY!', 0, N'IIDX-GOOOOOOOOOLD')
GO
INSERT [dbo].[Posts] ([ID], [Author], [Published], [Modified], [Title], [Text], [Mobile], [Slug]) VALUES (11, N'strider-', CAST(0x00009D4D00000000 AS DateTime), NULL, N'Happy Birfday', N'WOW 30', 0, N'Happy-Birfday')
GO
INSERT [dbo].[Posts] ([ID], [Author], [Published], [Modified], [Title], [Text], [Mobile], [Slug]) VALUES (15, N'strider-', CAST(0x00009A9700000000 AS DateTime), CAST(0x00009A9900000000 AS DateTime), N'Black to tha Future', N'Testing old date ranges for the archive page is awesome', 1, N'Black-to-tha-Future')
GO
INSERT [dbo].[Posts] ([ID], [Author], [Published], [Modified], [Title], [Text], [Mobile], [Slug]) VALUES (16, N'strider-', CAST(0x00009D6B013EC33B AS DateTime), CAST(0x00009D6B0146825F AS DateTime), N'sup', N'<b>I RULE </b>', 0, N'sup')
GO
SET IDENTITY_INSERT [dbo].[Posts] OFF
GO
ALTER TABLE [dbo].[Projects] ADD  CONSTRAINT [DF_Projects_Progress]  DEFAULT ((0)) FOR [Progress]
GO
ALTER TABLE [dbo].[Posts] ADD  CONSTRAINT [DF_Posts_Mobile]  DEFAULT ((0)) FOR [Mobile]
GO
