---------CREATE TABLE-----------
create table Tbl_payments_detail(payment_ID int not null primary key,
userID int foreign key(userID) references TBL_USER(USER_ID),
bID int
foreign key(bID) references booking(booking_id),
amount int not null,
mode varchar(50) not null,
status varchar(20) not null,
CreatedBy varchar(50) not null,
CreatedDate datetime not null default getdate(),
ModifiedBy varchar(50) not null,
ModifiedDate datetime not null default getdate(),
RecordStatus bit default 1,
RowGUID varchar(max) default newid());

-------------STORED PROCEDURE------------------
ALTER PROCEDURE PAY_CRUD 
(@payment_ID int, 
@userID int, 
@bID int,
@amount int,
@mode varchar(30),
@status varchar(40),
@CreatedBy varchar(40),
@ModifiedBy varchar(40),
@StatementType NVARCHAR(20) = '')
AS
  BEGIN
      IF @StatementType = 'Insert'
        BEGIN
            INSERT INTO Tbl_payments_detail (payment_ID,userID,bID,amount,mode,status,CreatedBy,ModifiedBy)values(@payment_ID,@userID,@bID,@amount,@mode,@status,@CreatedBy,@ModifiedBy)
        END
      ELSE IF @StatementType = 'Update'
        BEGIN
            UPDATE Tbl_payments_detail set userID=@userID,bID=@bID,amount=@amount,mode=@mode,status=@status ,CreatedBy=@CreatedBy,ModifiedBy=@ModifiedBy where payment_ID=@payment_ID;
        END
END       
---UPDATE  u_id int FOREIGN KEY(u_id) REFERENCES user_table(id),

DROP PROCEDURE PAY_CRUD

SELECT * FROM Tbl_payments_detail
EXEC PAY_CRUD 40,5,2,500,'CreditCard','Success','DIVYA','DIVYA','Insert'
EXEC PAY_CRUD 30,5,1,500,'CreditCard','Failed','DIVYA','DIVYA','Insert'

EXEC PAY_CRUD 30,5,1,500,'CreditCard','Successful','DIVYA','DIVYA','Update'


CREATE PROCEDURE CRUD_SELECT
AS
	BEGIN
		SELECT * FROM  Tbl_payments_detail
END

EXEC CRUD_SELECT
