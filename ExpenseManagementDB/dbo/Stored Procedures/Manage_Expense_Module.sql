CREATE PROCEDURE [dbo].[Manage_Expense_Module]
@action varchar(100) = '',
@fromDate datetime = '',
@toDate datetime = '',
@expenseId bigint = 0,
@expenseDate datetime = '',
@expenseTypeId int = 0,
@expenseNarration varchar(1000) = '',
@amount decimal(18,2) = 0,
@userId bigint = 0,
@expenseUserId bigint = 0
AS
BEGIN
	declare @datetimeNow datetime = getdate()

	IF @action = 'loadDropdowns'
	BEGIN
		select expenseTypeDesc, expenseTypeId from tblExpenseType

		select userId, (firstName + ' ' + lastName) userName from tblUser where userId = @expenseUserId
	END
	ELSE IF @action = 'loadExpensesDetails'
	BEGIN
		select expenseId, expenseDate, et.expenseTypeDesc, expenseNarration, amount
		from tblExpense e
		join tblExpenseType et on et.expenseTypeId = e.expenseTypeId
		where expenseDate >= @fromDate 
			and expenseDate <= @toDate 
			and expenseUserId = @expenseUserId
			and e.expenseTypeId = IIF(@expenseTypeId = 0, e.expenseTypeId, @expenseTypeId)
		order by expenseDate desc
	END
	ELSE IF @action = 'loadExpenseDetailsTypeWise'
	BEGIN
		select et.expenseTypeDesc, sum(amount) amount
		from tblExpense e
		join tblExpenseType et on et.expenseTypeId = e.expenseTypeId
		where expenseDate >= @fromDate 
			and expenseDate <= @toDate 
			and expenseUserId = @expenseUserId
		group by e.expenseTypeId, et.expenseTypeDesc
		order by sum(amount) desc
	END
	ELSE IF @action = 'createExpense'
	BEGIN
		set @expenseId = (select isnull(max(expenseId), 0) + 1 from tblExpense)

		insert into tblExpense
		select @expenseId, @expenseDate, @expenseTypeId, @expenseNarration, @amount, @expenseUserId, @userId, @datetimeNow, 0 mUserId, '' mDatetime

		select 'Expense created successfully.' [message], 1 isSuccessful
	END
	ELSE IF @action = 'getExpesnseById'
	BEGIN
		select expenseId, expenseDate, e.expenseTypeId, et.expenseTypeDesc, expenseNarration, amount
		from tblExpense e
		join tblExpenseType et on et.expenseTypeId = e.expenseTypeId
		where expenseId = @expenseId 
	END
	ELSE IF @action = 'editExpense'
	BEGIN
		update tblExpense
		set expenseNarration = @expenseNarration,
			expenseTypeId = @expenseTypeId,
			amount = @amount,
			mUserId = @userId,
			mDatetime = @datetimeNow
		where expenseId = @expenseId

		select 'Expense updated successfully.' [message], 1 isSuccessful
	END
END


--- Expense Type 
--- Food
--- Transport