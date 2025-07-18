USE [dbInt_Survey]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeId] [int] NOT NULL,
	[EmployeeName] [varchar](200) NULL,
	[EmployeeEmail] [varchar](255) NULL,
	[Designation] [varchar](200) NULL,
	[RoleId] [int] NULL,
	[IsActive] [int] NULL,
	[CreatedBy] [varchar](10) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [varchar](10) NULL,
	[ModifiedDate] [date] NULL,
	[Password] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FunctionalRequirements]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FunctionalRequirements](
	[FRId] [int] IDENTITY(1,1) NOT NULL,
	[FRName] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FRId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hospital]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hospital](
	[hosid] [int] NULL,
	[hosname] [varchar](250) NULL,
	[hosadd] [varchar](250) NULL,
	[hoscity] [varchar](250) NULL,
	[hosnum] [varchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[orderid] [int] NOT NULL,
	[ordernum] [int] NOT NULL,
	[id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[orderid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[persons]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[persons](
	[id] [int] NOT NULL,
	[fullname] [varchar](250) NOT NULL,
	[age] [int] NULL,
	[city] [varchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionMaster]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionMaster](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionText] [text] NULL,
	[QuestionType] [varchar](50) NULL,
	[Options] [text] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](100) NULL,
	[CorrectAnswer] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleFunctionalMapping]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleFunctionalMapping](
	[RoleId] [int] NULL,
	[FRId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](200) NULL,
	[IsActive] [int] NULL,
	[CreatedBy] [varchar](10) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedDate] [date] NULL,
	[ModifiedBy] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Survey]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Survey](
	[SurveyID] [int] IDENTITY(1,1) NOT NULL,
	[SurveyName] [varchar](255) NULL,
	[Description] [text] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SurveyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyAssignments]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyAssignments](
	[AssignmentID] [int] IDENTITY(1,1) NOT NULL,
	[SurveyID] [int] NULL,
	[EmployeeID] [int] NULL,
	[AssignedDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[IsActive] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[AssignmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyQuestionMapping]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyQuestionMapping](
	[MappingID] [int] IDENTITY(1,1) NOT NULL,
	[SurveyID] [int] NULL,
	[QuestionID] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyResponses]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyResponses](
	[ResponseID] [int] IDENTITY(1,1) NOT NULL,
	[SurveyID] [int] NULL,
	[EmployeeID] [int] NULL,
	[QuestionID] [int] NULL,
	[Answer] [text] NULL,
	[SubmittedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[Status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ResponseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Employee] ([EmployeeId], [EmployeeName], [EmployeeEmail], [Designation], [RoleId], [IsActive], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Password]) VALUES (1, N'Priya', N'admin@survey.com', N'HR Head', 1, 1, N'Admin', CAST(N'2025-06-16' AS Date), N'Admin', CAST(N'2025-06-16' AS Date), N'a123')
INSERT [dbo].[Employee] ([EmployeeId], [EmployeeName], [EmployeeEmail], [Designation], [RoleId], [IsActive], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Password]) VALUES (2, N'Dharshini', N'user@survey.com', N'Junior Analyst', 2, 1, N'Admin', CAST(N'2025-06-16' AS Date), N'Admin', CAST(N'2025-06-16' AS Date), N'user123')
INSERT [dbo].[Employee] ([EmployeeId], [EmployeeName], [EmployeeEmail], [Designation], [RoleId], [IsActive], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Password]) VALUES (3, N'Pavi ', N'pavi@survey.com', N'Intern', 2, 1, N'Admin', CAST(N'2025-06-19' AS Date), N'Admin', CAST(N'2025-06-19' AS Date), N'pavi123')
INSERT [dbo].[Employee] ([EmployeeId], [EmployeeName], [EmployeeEmail], [Designation], [RoleId], [IsActive], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Password]) VALUES (4, N'Vicky ', N'vicky@survey.com', N'Intern', 2, 1, N'Admin', CAST(N'2025-06-19' AS Date), N'Admin', CAST(N'2025-06-19' AS Date), N'vicky123')
GO
SET IDENTITY_INSERT [dbo].[FunctionalRequirements] ON 

INSERT [dbo].[FunctionalRequirements] ([FRId], [FRName]) VALUES (1, N'Create Survey')
INSERT [dbo].[FunctionalRequirements] ([FRId], [FRName]) VALUES (2, N'Assign Survey')
INSERT [dbo].[FunctionalRequirements] ([FRId], [FRName]) VALUES (3, N'View Submissions')
INSERT [dbo].[FunctionalRequirements] ([FRId], [FRName]) VALUES (4, N'Generate Reports')
INSERT [dbo].[FunctionalRequirements] ([FRId], [FRName]) VALUES (5, N'Manage Users')
SET IDENTITY_INSERT [dbo].[FunctionalRequirements] OFF
GO
INSERT [dbo].[hospital] ([hosid], [hosname], [hosadd], [hoscity], [hosnum]) VALUES (234, N'hindumission', N'100 feet road', N'chennai', N'866345678')
INSERT [dbo].[hospital] ([hosid], [hosname], [hosadd], [hoscity], [hosnum]) VALUES (234, N'Hindu Mission', N'100 Feet Road', N'Chennai', N'866345678')
INSERT [dbo].[hospital] ([hosid], [hosname], [hosadd], [hoscity], [hosnum]) VALUES (235, N'Apollo Hospitals', N'Greams Road', N'Chennai', N'9840123456')
INSERT [dbo].[hospital] ([hosid], [hosname], [hosadd], [hoscity], [hosnum]) VALUES (236, N'Fortis Hospital', N'Bannerghatta Road', N'Bangalore', N'9988776655')
INSERT [dbo].[hospital] ([hosid], [hosname], [hosadd], [hoscity], [hosnum]) VALUES (237, N'AIIMS', N'Ansari Nagar', N'Delhi', N'9112345678')
INSERT [dbo].[hospital] ([hosid], [hosname], [hosadd], [hoscity], [hosnum]) VALUES (238, N'CMC', N'Vellore Road', N'Vellore', N'9345678912')
INSERT [dbo].[hospital] ([hosid], [hosname], [hosadd], [hoscity], [hosnum]) VALUES (239, N'Kauvery Hospital', N'Alwarpet', N'Chennai', N'9887654321')
INSERT [dbo].[hospital] ([hosid], [hosname], [hosadd], [hoscity], [hosnum]) VALUES (240, N'Manipal Hospital', N'Old Airport Road', N'Bangalore', N'9765432187')
INSERT [dbo].[hospital] ([hosid], [hosname], [hosadd], [hoscity], [hosnum]) VALUES (241, N'Max Hospital', N'Saket', N'Delhi', N'9876543210')
INSERT [dbo].[hospital] ([hosid], [hosname], [hosadd], [hoscity], [hosnum]) VALUES (242, N'SRM Hospital', N'Potheri', N'Chennai', N'9090909090')
INSERT [dbo].[hospital] ([hosid], [hosname], [hosadd], [hoscity], [hosnum]) VALUES (243, N'MIOT International', N'Manapakkam', N'Chennai', N'9012345678')
GO
INSERT [dbo].[orders] ([orderid], [ordernum], [id]) VALUES (101, 5001, 1)
INSERT [dbo].[orders] ([orderid], [ordernum], [id]) VALUES (102, 5002, 2)
INSERT [dbo].[orders] ([orderid], [ordernum], [id]) VALUES (103, 5003, 3)
INSERT [dbo].[orders] ([orderid], [ordernum], [id]) VALUES (104, 5004, 3)
INSERT [dbo].[orders] ([orderid], [ordernum], [id]) VALUES (105, 5005, 5)
INSERT [dbo].[orders] ([orderid], [ordernum], [id]) VALUES (106, 5006, 6)
INSERT [dbo].[orders] ([orderid], [ordernum], [id]) VALUES (107, 5007, 7)
INSERT [dbo].[orders] ([orderid], [ordernum], [id]) VALUES (108, 5008, 8)
INSERT [dbo].[orders] ([orderid], [ordernum], [id]) VALUES (109, 5009, 9)
INSERT [dbo].[orders] ([orderid], [ordernum], [id]) VALUES (110, 5010, 10)
INSERT [dbo].[orders] ([orderid], [ordernum], [id]) VALUES (111, 5001, 10)
GO
INSERT [dbo].[persons] ([id], [fullname], [age], [city]) VALUES (1, N'Alice Johnson', 28, N'Mumbai')
INSERT [dbo].[persons] ([id], [fullname], [age], [city]) VALUES (2, N'Bob Smith', 35, N'Delhi')
INSERT [dbo].[persons] ([id], [fullname], [age], [city]) VALUES (3, N'Catherine Green', 42, N'Chennai')
INSERT [dbo].[persons] ([id], [fullname], [age], [city]) VALUES (4, N'David White', 31, N'Kolkata')
INSERT [dbo].[persons] ([id], [fullname], [age], [city]) VALUES (5, N'Emily Brown', 25, N'chennai')
INSERT [dbo].[persons] ([id], [fullname], [age], [city]) VALUES (6, N'Frank Wilson', 29, N'Bangalore')
INSERT [dbo].[persons] ([id], [fullname], [age], [city]) VALUES (7, N'Grace Miller', 33, N'Pune')
INSERT [dbo].[persons] ([id], [fullname], [age], [city]) VALUES (8, N'Henry Davis', 40, N'Ahmedabad')
INSERT [dbo].[persons] ([id], [fullname], [age], [city]) VALUES (9, N'Isabella Taylor', 27, N'Chandigarh')
INSERT [dbo].[persons] ([id], [fullname], [age], [city]) VALUES (10, N'Jack Moore', 38, N'Jaipur')
GO
SET IDENTITY_INSERT [dbo].[QuestionMaster] ON 

INSERT [dbo].[QuestionMaster] ([QuestionID], [QuestionText], [QuestionType], [Options], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [CorrectAnswer]) VALUES (1, N'just write about your experience', N'Short Answer', N'', 1, CAST(N'2025-06-18T18:16:48.057' AS DateTime), N'Admin', CAST(N'2025-06-18T18:16:48.057' AS DateTime), N'Admin', N'Very Good')
INSERT [dbo].[QuestionMaster] ([QuestionID], [QuestionText], [QuestionType], [Options], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [CorrectAnswer]) VALUES (2, N'give your feedback about the company', N'Short Answer', N'', 1, CAST(N'2025-06-19T10:09:31.553' AS DateTime), N'Admin', CAST(N'2025-06-19T10:09:31.553' AS DateTime), N'Admin', NULL)
INSERT [dbo].[QuestionMaster] ([QuestionID], [QuestionText], [QuestionType], [Options], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [CorrectAnswer]) VALUES (3, N'write about your experience in office', N'Short Answer', N'', 1, CAST(N'2025-06-19T10:09:31.560' AS DateTime), N'Admin', CAST(N'2025-06-19T10:09:31.560' AS DateTime), N'Admin', NULL)
INSERT [dbo].[QuestionMaster] ([QuestionID], [QuestionText], [QuestionType], [Options], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [CorrectAnswer]) VALUES (4, N'Tell your feedback about the food inside the company', N'Short Answer', N'', 1, CAST(N'2025-06-19T12:17:35.863' AS DateTime), N'Admin', CAST(N'2025-06-19T12:17:35.863' AS DateTime), N'Admin', NULL)
INSERT [dbo].[QuestionMaster] ([QuestionID], [QuestionText], [QuestionType], [Options], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [CorrectAnswer]) VALUES (5, N'Write your opinion ', N'Short Answer', N'', 1, CAST(N'2025-06-19T14:45:04.610' AS DateTime), N'Admin', CAST(N'2025-06-19T14:45:04.610' AS DateTime), N'Admin', NULL)
INSERT [dbo].[QuestionMaster] ([QuestionID], [QuestionText], [QuestionType], [Options], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [CorrectAnswer]) VALUES (6, N'Give your feedback about the session', N'Short Answer', N'', 1, CAST(N'2025-06-19T14:54:55.187' AS DateTime), N'Admin', CAST(N'2025-06-19T14:54:55.187' AS DateTime), N'Admin', NULL)
INSERT [dbo].[QuestionMaster] ([QuestionID], [QuestionText], [QuestionType], [Options], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [CorrectAnswer]) VALUES (7, N'Are you satisfied with the environment in company', N'multiple_choice', N'more satisfied,satisfied,less satisfied,not satisfied', 1, CAST(N'2025-06-30T17:55:49.133' AS DateTime), N'1', CAST(N'2025-06-30T17:55:49.133' AS DateTime), N'1', NULL)
INSERT [dbo].[QuestionMaster] ([QuestionID], [QuestionText], [QuestionType], [Options], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [CorrectAnswer]) VALUES (8, N'Have you Learnt New things', N'checkboxes', N'Yes', 1, CAST(N'2025-07-08T17:22:47.413' AS DateTime), N'1', CAST(N'2025-07-08T17:22:47.413' AS DateTime), N'1', NULL)
INSERT [dbo].[QuestionMaster] ([QuestionID], [QuestionText], [QuestionType], [Options], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [CorrectAnswer]) VALUES (9, N'what is your native', N'multiple_choice', N'chennai,madurai,trichy,pondicherry', 1, CAST(N'2025-07-09T14:14:16.310' AS DateTime), N'1', CAST(N'2025-07-09T14:14:16.310' AS DateTime), N'1', NULL)
SET IDENTITY_INSERT [dbo].[QuestionMaster] OFF
GO
INSERT [dbo].[RoleFunctionalMapping] ([RoleId], [FRId]) VALUES (1, 1)
INSERT [dbo].[RoleFunctionalMapping] ([RoleId], [FRId]) VALUES (1, 2)
INSERT [dbo].[RoleFunctionalMapping] ([RoleId], [FRId]) VALUES (1, 3)
INSERT [dbo].[RoleFunctionalMapping] ([RoleId], [FRId]) VALUES (1, 4)
INSERT [dbo].[RoleFunctionalMapping] ([RoleId], [FRId]) VALUES (1, 5)
INSERT [dbo].[RoleFunctionalMapping] ([RoleId], [FRId]) VALUES (2, 3)
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (1, N'admin', 1, N'Admin', CAST(N'2025-06-16' AS Date), CAST(N'2025-06-16' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (2, N'admin', 0, N'Admin', CAST(N'2025-06-16' AS Date), CAST(N'2025-06-17' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (3, N'user', 1, N'Admin', CAST(N'2025-06-16' AS Date), CAST(N'2025-06-16' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (4, N'super admin', 0, N'Admin', CAST(N'2025-06-16' AS Date), CAST(N'2025-06-18' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (5, N'super user', 0, N'Admin', CAST(N'2025-06-16' AS Date), CAST(N'2025-06-18' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (6, N'small user', 0, N'Admin', CAST(N'2025-06-16' AS Date), CAST(N'2025-06-17' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (7, N'adminn', 0, N'Admin', CAST(N'2025-06-16' AS Date), CAST(N'2025-06-18' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (8, N'user', 0, N'Admin', CAST(N'2025-06-16' AS Date), CAST(N'2025-06-19' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (9, N'admin', 0, N'Admin', CAST(N'2025-06-17' AS Date), CAST(N'2025-07-15' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (10, N'adminn', 0, N'Admin', CAST(N'2025-06-17' AS Date), CAST(N'2025-06-18' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (11, N'test admin', 0, N'Admin', CAST(N'2025-06-17' AS Date), CAST(N'2025-06-19' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (12, N'admin', 0, N'Admin', CAST(N'2025-06-17' AS Date), CAST(N'2025-07-15' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (13, N'admin', 0, N'Admin', CAST(N'2025-06-18' AS Date), CAST(N'2025-07-15' AS Date), N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [IsActive], [CreatedBy], [CreatedDate], [ModifiedDate], [ModifiedBy]) VALUES (14, N'admin new', 0, N'Admin', CAST(N'2025-06-18' AS Date), CAST(N'2025-06-19' AS Date), N'Admin')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Survey] ON 

INSERT [dbo].[Survey] ([SurveyID], [SurveyName], [Description], [StartDate], [EndDate], [IsActive], [CreatedBy], [ModifiedDate], [ModifiedBy], [CreatedDate]) VALUES (1, N'feedback', N'employee feedback ', CAST(N'2025-08-01' AS Date), CAST(N'2026-08-01' AS Date), 1, 1, CAST(N'2025-06-18T18:16:48.050' AS DateTime), N'Admin', CAST(N'2025-06-18T18:16:48.050' AS DateTime))
INSERT [dbo].[Survey] ([SurveyID], [SurveyName], [Description], [StartDate], [EndDate], [IsActive], [CreatedBy], [ModifiedDate], [ModifiedBy], [CreatedDate]) VALUES (2, N'internship feedback', N'interns feedback', CAST(N'2025-07-02' AS Date), CAST(N'2025-09-02' AS Date), 1, 1, CAST(N'2025-06-19T10:09:31.543' AS DateTime), N'Admin', CAST(N'2025-06-19T10:09:31.543' AS DateTime))
INSERT [dbo].[Survey] ([SurveyID], [SurveyName], [Description], [StartDate], [EndDate], [IsActive], [CreatedBy], [ModifiedDate], [ModifiedBy], [CreatedDate]) VALUES (3, N'Food Feedback', N'Employee feedback about food', CAST(N'2025-07-06' AS Date), CAST(N'2025-08-06' AS Date), 1, 1, CAST(N'2025-06-19T12:17:35.857' AS DateTime), N'Admin', CAST(N'2025-06-19T12:17:35.857' AS DateTime))
INSERT [dbo].[Survey] ([SurveyID], [SurveyName], [Description], [StartDate], [EndDate], [IsActive], [CreatedBy], [ModifiedDate], [ModifiedBy], [CreatedDate]) VALUES (4, N'General Feedback', N'Give the feedback', CAST(N'2025-07-06' AS Date), CAST(N'2025-09-07' AS Date), 1, 1, CAST(N'2025-06-19T14:45:04.603' AS DateTime), N'Admin', CAST(N'2025-06-19T14:45:04.603' AS DateTime))
INSERT [dbo].[Survey] ([SurveyID], [SurveyName], [Description], [StartDate], [EndDate], [IsActive], [CreatedBy], [ModifiedDate], [ModifiedBy], [CreatedDate]) VALUES (5, N'Session Feedback', N'Employee feedback about session', CAST(N'2025-05-23' AS Date), CAST(N'2025-09-26' AS Date), 1, 1, CAST(N'2025-06-19T14:54:55.180' AS DateTime), N'Admin', CAST(N'2025-06-19T14:54:55.180' AS DateTime))
INSERT [dbo].[Survey] ([SurveyID], [SurveyName], [Description], [StartDate], [EndDate], [IsActive], [CreatedBy], [ModifiedDate], [ModifiedBy], [CreatedDate]) VALUES (6, N'Employee Satisfaction Survey', N'employee satisfaction about the company', CAST(N'2025-06-30' AS Date), CAST(N'2025-07-04' AS Date), 1, 1, CAST(N'2025-06-30T17:55:49.127' AS DateTime), N'1', CAST(N'2025-06-30T17:55:49.127' AS DateTime))
INSERT [dbo].[Survey] ([SurveyID], [SurveyName], [Description], [StartDate], [EndDate], [IsActive], [CreatedBy], [ModifiedDate], [ModifiedBy], [CreatedDate]) VALUES (7, N'Session Feedback', N'employee feedback about the latest session', CAST(N'2025-07-08' AS Date), CAST(N'2025-07-11' AS Date), 1, 1, CAST(N'2025-07-08T17:22:47.407' AS DateTime), N'1', CAST(N'2025-07-08T17:22:47.407' AS DateTime))
INSERT [dbo].[Survey] ([SurveyID], [SurveyName], [Description], [StartDate], [EndDate], [IsActive], [CreatedBy], [ModifiedDate], [ModifiedBy], [CreatedDate]) VALUES (8, N'Native Survey', N'Employee native survey', CAST(N'2025-07-08' AS Date), CAST(N'2025-07-12' AS Date), 1, 1, CAST(N'2025-07-09T14:14:16.300' AS DateTime), N'1', CAST(N'2025-07-09T14:14:15.170' AS DateTime))
SET IDENTITY_INSERT [dbo].[Survey] OFF
GO
SET IDENTITY_INSERT [dbo].[SurveyAssignments] ON 

INSERT [dbo].[SurveyAssignments] ([AssignmentID], [SurveyID], [EmployeeID], [AssignedDate], [DueDate], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, 1, 2, CAST(N'2025-06-19T16:25:11.763' AS DateTime), CAST(N'2025-06-26T00:00:00.000' AS DateTime), 1, CAST(N'2025-06-19T16:25:11.763' AS DateTime), N'Admin', CAST(N'2025-06-19T16:25:11.763' AS DateTime), N'Admin')
INSERT [dbo].[SurveyAssignments] ([AssignmentID], [SurveyID], [EmployeeID], [AssignedDate], [DueDate], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (2, 5, 4, CAST(N'2025-06-19T16:26:39.793' AS DateTime), CAST(N'2025-06-27T00:00:00.000' AS DateTime), 1, CAST(N'2025-06-19T16:26:39.793' AS DateTime), N'Admin', CAST(N'2025-06-19T16:26:39.793' AS DateTime), N'Admin')
INSERT [dbo].[SurveyAssignments] ([AssignmentID], [SurveyID], [EmployeeID], [AssignedDate], [DueDate], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (3, 5, 3, CAST(N'2025-06-19T16:55:14.053' AS DateTime), CAST(N'2025-06-25T00:00:00.000' AS DateTime), 1, CAST(N'2025-06-19T16:55:14.053' AS DateTime), N'Admin', CAST(N'2025-06-19T16:55:14.053' AS DateTime), N'Admin')
INSERT [dbo].[SurveyAssignments] ([AssignmentID], [SurveyID], [EmployeeID], [AssignedDate], [DueDate], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (4, 2, 4, CAST(N'2025-06-20T09:55:49.773' AS DateTime), CAST(N'2025-06-27T00:00:00.000' AS DateTime), 1, CAST(N'2025-06-20T09:55:49.773' AS DateTime), N'Admin', CAST(N'2025-06-20T09:55:49.773' AS DateTime), N'Admin')
INSERT [dbo].[SurveyAssignments] ([AssignmentID], [SurveyID], [EmployeeID], [AssignedDate], [DueDate], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (5, 4, 3, CAST(N'2025-06-20T11:04:30.623' AS DateTime), CAST(N'2025-06-27T00:00:00.000' AS DateTime), 1, CAST(N'2025-06-20T11:04:30.623' AS DateTime), N'Admin', CAST(N'2025-06-20T11:04:30.623' AS DateTime), N'Admin')
INSERT [dbo].[SurveyAssignments] ([AssignmentID], [SurveyID], [EmployeeID], [AssignedDate], [DueDate], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, 2, 4, CAST(N'2025-06-27T11:53:48.940' AS DateTime), CAST(N'2025-07-02T00:00:00.000' AS DateTime), 1, CAST(N'2025-06-27T11:53:48.940' AS DateTime), N'Admin', CAST(N'2025-06-27T11:53:48.940' AS DateTime), N'Admin')
INSERT [dbo].[SurveyAssignments] ([AssignmentID], [SurveyID], [EmployeeID], [AssignedDate], [DueDate], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (7, 2, 3, CAST(N'2025-06-27T11:53:48.940' AS DateTime), CAST(N'2025-07-02T00:00:00.000' AS DateTime), 1, CAST(N'2025-06-27T11:53:48.940' AS DateTime), N'Admin', CAST(N'2025-06-27T11:53:48.940' AS DateTime), N'Admin')
INSERT [dbo].[SurveyAssignments] ([AssignmentID], [SurveyID], [EmployeeID], [AssignedDate], [DueDate], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, 3, 3, CAST(N'2025-06-30T16:12:43.763' AS DateTime), CAST(N'2025-07-09T00:00:00.000' AS DateTime), 1, CAST(N'2025-06-30T16:12:43.763' AS DateTime), N'Admin', CAST(N'2025-06-30T16:12:43.763' AS DateTime), N'Admin')
INSERT [dbo].[SurveyAssignments] ([AssignmentID], [SurveyID], [EmployeeID], [AssignedDate], [DueDate], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (9, 6, 2, CAST(N'2025-06-30T17:56:24.300' AS DateTime), CAST(N'2025-07-04T00:00:00.000' AS DateTime), 1, CAST(N'2025-06-30T17:56:24.300' AS DateTime), N'Admin', CAST(N'2025-06-30T17:56:24.300' AS DateTime), N'Admin')
INSERT [dbo].[SurveyAssignments] ([AssignmentID], [SurveyID], [EmployeeID], [AssignedDate], [DueDate], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (10, 7, 3, CAST(N'2025-07-08T17:23:14.757' AS DateTime), CAST(N'2025-07-11T00:00:00.000' AS DateTime), 1, CAST(N'2025-07-08T17:23:14.757' AS DateTime), N'Admin', CAST(N'2025-07-08T17:23:14.757' AS DateTime), N'Admin')
INSERT [dbo].[SurveyAssignments] ([AssignmentID], [SurveyID], [EmployeeID], [AssignedDate], [DueDate], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (11, 8, 4, CAST(N'2025-07-09T14:16:46.063' AS DateTime), CAST(N'2025-07-12T00:00:00.000' AS DateTime), 1, CAST(N'2025-07-09T14:16:46.063' AS DateTime), N'Admin', CAST(N'2025-07-09T14:16:46.063' AS DateTime), N'Admin')
SET IDENTITY_INSERT [dbo].[SurveyAssignments] OFF
GO
SET IDENTITY_INSERT [dbo].[SurveyQuestionMapping] ON 

INSERT [dbo].[SurveyQuestionMapping] ([MappingID], [SurveyID], [QuestionID], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, 1, 1, 1, CAST(N'2025-06-18T18:16:48.060' AS DateTime), N'Admin', CAST(N'2025-06-18T18:16:48.060' AS DateTime), N'Admin')
INSERT [dbo].[SurveyQuestionMapping] ([MappingID], [SurveyID], [QuestionID], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (2, 2, 2, 1, CAST(N'2025-06-19T10:09:31.560' AS DateTime), N'Admin', CAST(N'2025-06-19T10:09:31.560' AS DateTime), N'Admin')
INSERT [dbo].[SurveyQuestionMapping] ([MappingID], [SurveyID], [QuestionID], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (3, 2, 3, 1, CAST(N'2025-06-19T10:09:31.567' AS DateTime), N'Admin', CAST(N'2025-06-19T10:09:31.567' AS DateTime), N'Admin')
INSERT [dbo].[SurveyQuestionMapping] ([MappingID], [SurveyID], [QuestionID], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (4, 3, 4, 1, CAST(N'2025-06-19T12:17:35.867' AS DateTime), N'Admin', CAST(N'2025-06-19T12:17:35.867' AS DateTime), N'Admin')
INSERT [dbo].[SurveyQuestionMapping] ([MappingID], [SurveyID], [QuestionID], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (5, 4, 5, 1, CAST(N'2025-06-19T14:45:04.613' AS DateTime), N'Admin', CAST(N'2025-06-19T14:45:04.613' AS DateTime), N'Admin')
INSERT [dbo].[SurveyQuestionMapping] ([MappingID], [SurveyID], [QuestionID], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, 5, 6, 1, CAST(N'2025-06-19T14:54:55.187' AS DateTime), N'Admin', CAST(N'2025-06-19T14:54:55.187' AS DateTime), N'Admin')
INSERT [dbo].[SurveyQuestionMapping] ([MappingID], [SurveyID], [QuestionID], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (7, 6, 7, 1, CAST(N'2025-06-30T17:55:49.137' AS DateTime), N'1', CAST(N'2025-06-30T17:55:49.137' AS DateTime), N'1')
INSERT [dbo].[SurveyQuestionMapping] ([MappingID], [SurveyID], [QuestionID], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, 7, 8, 1, CAST(N'2025-07-08T17:22:47.420' AS DateTime), N'1', CAST(N'2025-07-08T17:22:47.420' AS DateTime), N'1')
INSERT [dbo].[SurveyQuestionMapping] ([MappingID], [SurveyID], [QuestionID], [IsActive], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (9, 8, 9, 1, CAST(N'2025-07-09T14:14:16.317' AS DateTime), N'1', CAST(N'2025-07-09T14:14:16.317' AS DateTime), N'1')
SET IDENTITY_INSERT [dbo].[SurveyQuestionMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[SurveyResponses] ON 

INSERT [dbo].[SurveyResponses] ([ResponseID], [SurveyID], [EmployeeID], [QuestionID], [Answer], [SubmittedDate], [CreatedBy], [Status]) VALUES (4, 1, 2, 1, N'Very Good', CAST(N'2025-06-23T10:16:11.997' AS DateTime), 1, N'submitted')
INSERT [dbo].[SurveyResponses] ([ResponseID], [SurveyID], [EmployeeID], [QuestionID], [Answer], [SubmittedDate], [CreatedBy], [Status]) VALUES (5, 2, 3, 2, N'Nice', CAST(N'2025-06-30T15:05:15.870' AS DateTime), NULL, N'submitted')
INSERT [dbo].[SurveyResponses] ([ResponseID], [SurveyID], [EmployeeID], [QuestionID], [Answer], [SubmittedDate], [CreatedBy], [Status]) VALUES (6, 2, 3, 3, N'Nice ', CAST(N'2025-06-30T15:05:15.890' AS DateTime), NULL, N'submitted')
INSERT [dbo].[SurveyResponses] ([ResponseID], [SurveyID], [EmployeeID], [QuestionID], [Answer], [SubmittedDate], [CreatedBy], [Status]) VALUES (7, 4, 3, 5, N'Good', CAST(N'2025-06-30T15:51:27.880' AS DateTime), NULL, N'submitted')
INSERT [dbo].[SurveyResponses] ([ResponseID], [SurveyID], [EmployeeID], [QuestionID], [Answer], [SubmittedDate], [CreatedBy], [Status]) VALUES (8, 5, 3, 6, N'good', CAST(N'2025-06-30T16:11:11.463' AS DateTime), NULL, N'submitted')
INSERT [dbo].[SurveyResponses] ([ResponseID], [SurveyID], [EmployeeID], [QuestionID], [Answer], [SubmittedDate], [CreatedBy], [Status]) VALUES (9, 6, 2, 7, N'satisfied', CAST(N'2025-06-30T18:03:38.617' AS DateTime), NULL, N'submitted')
INSERT [dbo].[SurveyResponses] ([ResponseID], [SurveyID], [EmployeeID], [QuestionID], [Answer], [SubmittedDate], [CreatedBy], [Status]) VALUES (10, 3, 3, 4, N'nice', CAST(N'2025-07-02T16:15:03.790' AS DateTime), NULL, N'submitted')
INSERT [dbo].[SurveyResponses] ([ResponseID], [SurveyID], [EmployeeID], [QuestionID], [Answer], [SubmittedDate], [CreatedBy], [Status]) VALUES (11, 7, 3, 8, N'Yes', CAST(N'2025-07-09T10:56:30.397' AS DateTime), NULL, N'submitted')
INSERT [dbo].[SurveyResponses] ([ResponseID], [SurveyID], [EmployeeID], [QuestionID], [Answer], [SubmittedDate], [CreatedBy], [Status]) VALUES (12, 8, 4, 9, N'madurai', CAST(N'2025-07-09T14:20:52.910' AS DateTime), NULL, N'submitted')
SET IDENTITY_INSERT [dbo].[SurveyResponses] OFF
GO
ALTER TABLE [dbo].[Survey] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SurveyResponses] ADD  DEFAULT (getdate()) FOR [SubmittedDate]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_RoleId]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([id])
REFERENCES [dbo].[persons] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [fk_id] FOREIGN KEY([id])
REFERENCES [dbo].[persons] ([id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [fk_id]
GO
ALTER TABLE [dbo].[RoleFunctionalMapping]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[RoleFunctionalMapping]  WITH CHECK ADD FOREIGN KEY([FRId])
REFERENCES [dbo].[FunctionalRequirements] ([FRId])
GO
ALTER TABLE [dbo].[SurveyAssignments]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[SurveyAssignments]  WITH CHECK ADD FOREIGN KEY([SurveyID])
REFERENCES [dbo].[Survey] ([SurveyID])
GO
ALTER TABLE [dbo].[SurveyQuestionMapping]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[QuestionMaster] ([QuestionID])
GO
ALTER TABLE [dbo].[SurveyQuestionMapping]  WITH CHECK ADD FOREIGN KEY([SurveyID])
REFERENCES [dbo].[Survey] ([SurveyID])
GO
ALTER TABLE [dbo].[SurveyResponses]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[SurveyResponses]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[QuestionMaster] ([QuestionID])
GO
ALTER TABLE [dbo].[SurveyResponses]  WITH CHECK ADD FOREIGN KEY([SurveyID])
REFERENCES [dbo].[Survey] ([SurveyID])
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteRole]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_DeleteRole]
    @RoleId INT,
    @ModifiedBy VARCHAR(10),
    @ModifiedDate DATE
AS
BEGIN
    UPDATE Roles
    SET 
        IsActive = 0,
        ModifiedBy = @ModifiedBy,
        ModifiedDate = @ModifiedDate
    WHERE RoleId = @RoleId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAssignedEmployeesForSurvey]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAssignedEmployeesForSurvey]
    @SurveyID INT
AS
BEGIN
    SELECT sa.SurveyID, sa.EmployeeID, e.EmployeeName
    FROM SurveyAssignments sa
    JOIN Employee e ON sa.EmployeeID = e.EmployeeId
    WHERE sa.SurveyID = @SurveyID AND sa.IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCombinedSurveyResponses]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCombinedSurveyResponses]
    @SurveyID INT = NULL,
    @EmployeeIDs NVARCHAR(MAX) = NULL  -- Pass comma-separated Employee IDs
AS
BEGIN
    SET NOCOUNT ON;

    -- Temp table to hold split Employee IDs
    DECLARE @EmployeeTable TABLE (EmployeeID INT);

    IF @EmployeeIDs IS NOT NULL AND LEN(@EmployeeIDs) > 0
    BEGIN
        INSERT INTO @EmployeeTable (EmployeeID)
        SELECT CAST(value AS INT)
        FROM STRING_SPLIT(@EmployeeIDs, ',');
    END

  
    SELECT 
        s.SurveyID, s.SurveyName, s.StartDate, s.EndDate,
        qm.QuestionID, qm.QuestionText, qm.QuestionType, qm.Options, qm.CorrectAnswer,
        ISNULL(e.EmployeeId, sa.EmployeeID) AS EmployeeID,
        ISNULL(e.EmployeeName, ea.EmployeeName) AS EmployeeName,
        sr.Answer
    FROM Survey s
    JOIN SurveyQuestionMapping sqm ON s.SurveyID = sqm.SurveyID
    JOIN QuestionMaster qm ON sqm.QuestionID = qm.QuestionID
    LEFT JOIN SurveyAssignments sa ON sa.SurveyID = s.SurveyID AND sa.IsActive = 1
    LEFT JOIN Employee ea ON ea.EmployeeId = sa.EmployeeID
    LEFT JOIN SurveyResponses sr ON sr.SurveyID = s.SurveyID AND sr.QuestionID = qm.QuestionID
        AND sr.EmployeeID = sa.EmployeeID
    LEFT JOIN Employee e ON e.EmployeeId = sr.EmployeeID
    WHERE s.IsActive = 1 and sa.EmployeeID is not null
    AND (@SurveyID IS NULL OR s.SurveyID = @SurveyID)
    AND (
        @EmployeeIDs IS NULL OR
        sa.EmployeeID IN (SELECT EmployeeID FROM @EmployeeTable)
    )
    ORDER BY s.SurveyID, sa.EmployeeID, qm.QuestionID;
END;


GO
/****** Object:  StoredProcedure [dbo].[sp_GetRoles]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetRoles]
AS
BEGIN
    SELECT * FROM Roles WHERE IsActive = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSurveyAnswersBySurvey]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetSurveyAnswersBySurvey]
    @SurveyID INT
AS
BEGIN
    SELECT sr.SurveyID, sr.EmployeeID, e.EmployeeName,
           sr.QuestionID, sr.Answer
    FROM SurveyResponses sr
    JOIN Employee e ON sr.EmployeeID = e.EmployeeId
    WHERE sr.SurveyID = @SurveyID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSurveyAssignments]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetSurveyAssignments]
    @SurveyID INT
AS
BEGIN
    SELECT sa.SurveyID, sa.EmployeeID, e.EmployeeName
    FROM SurveyAssignments sa
    JOIN Employee e ON sa.EmployeeID = e.EmployeeId
    WHERE sa.SurveyID = @SurveyID AND sa.IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSurveyQuestionDetails]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetSurveyQuestionDetails]
    @SurveyID INT
AS
BEGIN
    SELECT s.SurveyID, s.SurveyName, s.StartDate, s.EndDate,
           qm.QuestionID, qm.QuestionText, qm.QuestionType, qm.Options, qm.CorrectAnswer
    FROM Survey s
    JOIN SurveyQuestionMapping sqm ON s.SurveyID = sqm.SurveyID
    JOIN QuestionMaster qm ON sqm.QuestionID = qm.QuestionID
    WHERE s.SurveyID = @SurveyID AND s.IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRole]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--update_insert
CREATE PROCEDURE [dbo].[sp_InsertRole]
    @RoleName VARCHAR(200),
    @CreatedBy VARCHAR(10),
    @CreatedDate DATE,
    @ModifiedBy VARCHAR(10),
    @ModifiedDate DATE
AS
BEGIN
    INSERT INTO Roles (RoleName, IsActive, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate)
    VALUES (@RoleName, 1, @CreatedBy, @CreatedDate, @ModifiedBy, @ModifiedDate);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateRole]    Script Date: 18-07-2025 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_UpdateRole]
    @RoleId INT,
    @RoleName VARCHAR(200),
    @IsActive INT,
    @ModifiedBy VARCHAR(10),
    @ModifiedDate DATE
AS
BEGIN
    UPDATE Roles
    SET 
        RoleName = @RoleName,
        IsActive = @IsActive,
        ModifiedBy = @ModifiedBy,
        ModifiedDate = @ModifiedDate
    WHERE RoleId = @RoleId;
END
GO
