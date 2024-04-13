CREATE TABLE [dbo].[tblExpense] (
    [rowId]            BIGINT          IDENTITY (1, 1) NOT NULL,
    [expenseId]        BIGINT          NOT NULL,
    [expenseDate]      DATETIME        CONSTRAINT [DF_tblExpense_expenseDate] DEFAULT ('') NULL,
    [expenseTypeId]    INT             CONSTRAINT [DF_tblExpense_expenseTypeId] DEFAULT ((0)) NULL,
    [expenseNarration] VARCHAR (1000)  CONSTRAINT [DF_tblExpense_expenseNarration] DEFAULT ('') NULL,
    [amount]           DECIMAL (18, 2) CONSTRAINT [DF_tblExpense_amount] DEFAULT ((0)) NULL,
    [expenseUserId]    BIGINT          CONSTRAINT [DF_tblExpense_expenseUserId] DEFAULT ((0)) NOT NULL,
    [cUserId]          BIGINT          CONSTRAINT [DF_tblExpense_cUserId] DEFAULT ((0)) NULL,
    [cDatetime]        DATETIME        CONSTRAINT [DF_tblExpense_cDatetime] DEFAULT ('') NULL,
    [mUserId]          BIGINT          CONSTRAINT [DF_tblExpense_mUserId] DEFAULT ((0)) NULL,
    [mDatetime]        DATETIME        CONSTRAINT [DF_tblExpense_mDatetime] DEFAULT ('') NULL,
    CONSTRAINT [PK_tblExpense] PRIMARY KEY CLUSTERED ([expenseId] ASC)
);

