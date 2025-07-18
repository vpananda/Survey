USE [dbInt_Survey]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  Table [dbo].[FunctionalRequirements]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  Table [dbo].[hospital]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  Table [dbo].[orders]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  Table [dbo].[persons]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  Table [dbo].[QuestionMaster]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  Table [dbo].[RoleFunctionalMapping]    Script Date: 11-07-2025 15:01:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleFunctionalMapping](
	[RoleId] [int] NULL,
	[FRId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  Table [dbo].[Survey]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  Table [dbo].[SurveyAssignments]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  Table [dbo].[SurveyQuestionMapping]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  Table [dbo].[SurveyResponses]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_DeleteRole]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetAssignedEmployeesForSurvey]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCombinedSurveyResponses]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetRoles]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetSurveyAnswersBySurvey]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetSurveyAssignments]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetSurveyQuestionDetails]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_InsertRole]    Script Date: 11-07-2025 15:01:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateRole]    Script Date: 11-07-2025 15:01:53 ******/
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
