using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CX_Graphql.Data;
using CX_Graphql.Types;
using CX_Identity.Models;
using HotChocolate;
using HotChocolate.Resolvers;
using HotChocolate.Types;
using Microsoft.EntityFrameworkCore;

namespace CX_Identity.Types
{
    public class ClientType : ObjectType<Client>
    {
        protected override void Configure(IObjectTypeDescriptor<Client> descriptor)
        {
            base.Configure(descriptor);
            descriptor.Field(a => a.Id)
                .Type<NonNullType<IntType>>();
            descriptor.Field(a => a.PublicKey)
                .Type<NonNullType<UuidType>>();
            descriptor.Field(a => a.Name)
                .Type<NonNullType<StringType>>();
            descriptor.Field(a => a.FilesharePath)
                .Type<NonNullType<StringType>>();
            descriptor.Field(a => a.CreatedOn)
                .Type<NonNullType<DateTimeType>>();
            descriptor.Field(a => a.LastUpdatedOn)
                .Type<NonNullType<DateTimeType>>();

            descriptor.Field<ClientType>(p => ResolveClientUIInfos(default, default, default))
               .Name("clientUIInfos")
               .Type<ClientUIInfosType>();

            descriptor.Field<ClientType>(p => ResolveUsers(default, default))
               .Name("users")
               .ListType<UserType>();
        }

        public async Task<ClientUIInfo> ResolveClientUIInfos(IResolverContext context, [Parent] Client client, [Service] IdentityContext  dbContext)
        {
            var dataLoader = context.BatchDataLoader<Guid, ClientUIInfo>(nameof(ResolveClientUIInfos), async clientUIInfosGuid =>
            {
                return await dbContext.ClientUIInfos
                    .Where(a => clientUIInfosGuid.Contains(a.PublicKey))
                    .ToDictionaryAsync(a => a.PublicKey, a => a);
            });

            return await dataLoader.LoadAsync(client.PublicKey, context.RequestAborted);
        }

        public async Task<IReadOnlyList<User>> ResolveUsers([Parent] Client client, [Service] IdentityContext dbContext)
        {
            return await dbContext.Users
                .Where(a => a.ClientGuid == client.PublicKey)
                .ToListAsync();
        }

    }
}
