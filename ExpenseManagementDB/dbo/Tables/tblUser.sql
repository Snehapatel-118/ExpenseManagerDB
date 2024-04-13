CREATE TABLE [dbo].[tblUser] (
    [rowId]      BIGINT       IDENTITY (1, 1) NOT NULL,
    [userId]     BIGINT       NOT NULL,
    [firstName]  VARCHAR (50) NOT NULL,
    [middleName] VARCHAR (50) CONSTRAINT [DF_tblUser_middleName] DEFAULT ('') NULL,
    [lastName]   VARCHAR (50) NOT NULL,
    [cUserId]    BIGINT       CONSTRAINT [DF_tblUser_cUserId] DEFAULT ((0)) NULL,
    [cDatetime]  BIGINT       CONSTRAINT [DF_tblUser_cDatetime] DEFAULT ('') NULL,
    [mUserId]    BIGINT       CONSTRAINT [DF_tblUser_mUserId] DEFAULT ((0)) NULL,
    [mDatetime]  BIGINT       CONSTRAINT [DF_tblUser_mDatetime] DEFAULT ('') NULL,
    CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED ([userId] ASC)
);

