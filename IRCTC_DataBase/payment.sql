---------MASTER TABLE----------------
use merit
create table paymode(mode_id  int not null primary key ,mode varchar(40),CreatedBy varchar(50) not null default 'Divya',
							CreatedDate datetime not null default getdate(), 
							ModifiedBy varchar(50) not null default 'Divya', 
							ModifiedDate datetime not null default getdate(), 
							RecordStatus bit default 1,
							RowGUID varchar(max) default newid())
select *from paymode

drop table paymode


---------CREATE TABLE-----------
create table Tbl_payments_detail(payment_ID int not null primary key,
userID int foreign key(userID) references TBL_USER(USER_ID),
bID int
foreign key(bID) references booking(booking_id),
mode_id int foreign key(mode_id) references pay(mode_id),
amount int not null,
status varchar(20) not null,
CreatedBy varchar(50) not null,
CreatedDate datetime not null default getdate(),
ModifiedBy varchar(50) not null,
ModifiedDate datetime not null default getdate(),
RecordStatus bit default 1,
RowGUID varchar(max) default newid());

drop table Tbl_payments_detail

-------------STORED PROCEDURE------------------
CREATE PROCEDURE PAY_CRUD 
(@payment_ID int, 
@userID int, 
@bID int,
@mode_id int,
@amount int,
@status varchar(40),
@CreatedBy varchar(40),
@ModifiedBy varchar(40),
@StatementType NVARCHAR(20) = '')
AS
  BEGIN
      IF @StatementType = 'Insert'
        BEGIN
            INSERT INTO Tbl_payments_detail (payment_ID,userID,bID,mode_id,amount,status,CreatedBy,ModifiedBy)values(@payment_ID,@userID,@bID,@mode_id,@amount,@status,@CreatedBy,@ModifiedBy)
        END
      ELSE IF @StatementType = 'Update'
        BEGIN
            UPDATE Tbl_payments_detail set userID=@userID,bID=@bID,mode_id=@mode_id,amount=@amount,status=@status ,CreatedBy=@CreatedBy,ModifiedBy=@ModifiedBy where payment_ID=@payment_ID;
        END
END       
---UPDATE  u_id int FOREIGN KEY(u_id) REFERENCES user_table(id),

DROP PROCEDURE PAY_CRUD

SELECT * FROM Tbl_payments_detail
EXEC PAY_CRUD 40,5,2,1,500,'Success','DIVYA','DIVYA','Insert'
EXEC PAY_CRUD 30,6,4,2,500,'Failed','DIVYA','DIVYA','Insert'

EXEC PAY_CRUD 30,6,4,2,500,'Successful','DIVYA','DIVYA','Update'


CREATE PROCEDURE CRUD_SELECT
AS
	BEGIN
		SELECT * FROM  Tbl_payments_detail
END

EXEC CRUD_SELECT