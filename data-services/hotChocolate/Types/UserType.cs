using CX_Identity.Models;
using HotChocolate.Types;
using CX_Graphql.Models;
using System.Threading.Tasks;
using HotChocolate;
using CX_Graphql.Data;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace CX_Graphql.Types
{
    public class UserType : ObjectType<User>
    {
        protected override void Configure(IObjectTypeDescriptor<User> descriptor)
        {
            base.Configure(descriptor);
            descriptor.Field(a => a.Id)
                .Type<NonNullType<IntType>>();            
            descriptor.Field(a => a.UserName)
                .Type<NonNullType<StringType>>();
            descriptor.Field(a => a.Enabled)
                .Type<NonNullType<BooleanType>>();
            descriptor.Field(a => a.PublicKey)
                .Type<NonNullType<UuidType>>();
            descriptor.Field(a => a.IdentityProviderUserId)
                .Type<NonNullType<StringType>>();
            descriptor.Field(a => a.InvalidLoginAttempts)
                .Type<NonNullType<IntType>>();
            descriptor.Field(a => a.IsLocked)
                .Type<NonNullType<BooleanType>>();
            descriptor.Field(a => a.CreatedOn)
                .Type<NonNullType<DateTimeType>>();
            descriptor.Field(a => a.LastChangedOn)
               .Type<NonNullType<DateTimeType>>();
            descriptor.Field(a => a.IdentityProviderId)
                .Type<NonNullType<IntType>>();
            descriptor.Field(a => a.ClientId)
                .Type<NonNullType<IntType>>();
            descriptor.Field(a => a.TestAccount)
                .Type<BooleanType>();
            descriptor.Field(a => a.IsManaged)
            .Type<BooleanType>();
            descriptor.Field(a => a.ClientGuid)
                .Type<NonNullType<UuidType>>();
            descriptor.Field(a => a.IdentityProviderGuid)
                .Type<NonNullType<UuidType>>();

            descriptor.Field<UserType>(p => ResolveUserClaims(default, default))
                .Name("userClaims")
                .ListType<UserClaimsType>();                
        }

        public async Task<IReadOnlyList<UserClaims>> ResolveUserClaims([Parent] User user, [Service] IdentityContext dbContext)
        {
            return await dbContext.UserClaims
                .Where(a => a.UserGuid == user.PublicKey)
                .ToListAsync();
        }

    }
}
