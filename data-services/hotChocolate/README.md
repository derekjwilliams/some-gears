# Hot Chocolate dotnet sln

This is intended to help developers learn graphql by using Hot Chocolate implementation.  https://hotchocolate.io/ This displays at the very basics for setting 4 different tables with relationships.  Hot Chocolate uses Entity Framework Core for its implementation.  I would first suggest you learn the basics to intermediate of Entity Framwork Core.  That will save a lot of pain.  

## Database setup
You will need to have a sqlServer database running locally or remotely.  This database needs to consist of 4 tables.  
To add the connection string in the sln:  the CS needs to live in appsettings.json under the sln context.
you will need to add it under the empty "ConnectionString" key

## Nuget packages to install
HotChocolate version 10.3.5 <br />
HotChocolate.AspNetCore version 10.3.5 <br />
HotChocolate.AspNetCore.Playground version 10.3.5 <br />
HotChocolate.AspNetCore.Voyager version 10.3.5<br />
HotChocolate.Subscriptions.InMemory version 10.3.5<br />
HotChocolate.Types.Filters version 10.3.5<br />
HotChocolate.Types.Sorting version 10.3.5<br />
Microsoft.EntityFrameworkcore.SqlServer 3.1.1<br />

## Clients Table

```sql

CREATE TABLE [dbo].[Clients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PublicKey] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[FilesharePath] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.Clients] PRIMARY KEY CLUSTERED 
(
	[PublicKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Clients] ADD  DEFAULT (newid()) FOR [PublicKey]
GO

ALTER TABLE [dbo].[Clients] ADD  DEFAULT (getutcdate()) FOR [CreatedOn]
GO

ALTER TABLE [dbo].[Clients] ADD  DEFAULT (getutcdate()) FOR [LastUpdatedOn]
GO
```

### ClientUIInfos

```sql
CREATE TABLE [dbo].[ClientUIInfos](
	[Id] [int] NOT NULL,
	[Theme] [nvarchar](2048) NULL,
	[PublicKey] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dbo.ClientUIInfos] PRIMARY KEY CLUSTERED 
(
	[PublicKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClientUIInfos]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ClientUIInfos_dbo.Clients_Id] FOREIGN KEY([PublicKey])
REFERENCES [dbo].[Clients] ([PublicKey])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[ClientUIInfos] CHECK CONSTRAINT [FK_dbo.ClientUIInfos_dbo.Clients_Id]
GO
```

### Users

```sql
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](500) NULL,
	[Enabled] [bit] NOT NULL,
	[PublicKey] [uniqueidentifier] NOT NULL,
	[IdentityProviderUserId] [nvarchar](50) NOT NULL,
	[InvalidLoginAttempts] [int] NOT NULL,
	[IsLocked] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastChangedOn] [datetime] NOT NULL,
	[IdentityProviderId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[TestAccount] [bit] NULL,
	[IsManaged] [bit] NULL,
	[ClientGuid] [uniqueidentifier] NOT NULL,
	[IdentityProviderGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dbo.Users] PRIMARY KEY CLUSTERED 
(
	[PublicKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Users] ADD  DEFAULT (newid()) FOR [PublicKey]
GO

ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IdentityProviderId]
GO

ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [ClientId]
GO

ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Users_dbo.Clients_ClientId] FOREIGN KEY([ClientGuid])
REFERENCES [dbo].[Clients] ([PublicKey])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_dbo.Users_dbo.Clients_ClientId]
GO
```

### UserClaims

```sql
CREATE TABLE [dbo].[UserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Type] [nvarchar](2048) NOT NULL,
	[Value] [nvarchar](2048) NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[UserGuid] [uniqueidentifier] NULL,
	[PublicKey] [uniqueidentifier] NOT NULL,
	[ClientGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserClaims] PRIMARY KEY CLUSTERED 
(
	[PublicKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UserClaims] ADD  DEFAULT (newid()) FOR [PublicKey]
GO

ALTER TABLE [dbo].[UserClaims] ADD  DEFAULT (newid()) FOR [ClientGuid]
GO

ALTER TABLE [dbo].[UserClaims]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo.UserClaims_dbo.Users_UserId] FOREIGN KEY([UserGuid])
REFERENCES [dbo].[Users] ([PublicKey])
GO

ALTER TABLE [dbo].[UserClaims] CHECK CONSTRAINT [FK_dbo.UserClaims_dbo.Users_UserId]
GO
```

### Getting Started in this repo

1. Clone the some-gears repo (e.g. `git clone https://github.com/derekjwilliams/some-gears.git`)

2. Add the tables to your sqlServer database (sql scripts above)

3. Add the connections string in the project sln file.  It needs to live in appsettings.json under the sln context. Add it under the empty "ConnectionString" key

4. You may need to install the nuget packages.  I used version 10.3.5 for all the Hot Chocolate packages.  I also used
EntityFrameworkCore.SqlServer 3.1.1

## Tech Stack (partial list)

* Entity Framework Core
* HotChocolate
* C#
* Linq

