using HotChocolate.Types;
using CX_Graphql.Models;

namespace CX_Graphql.Types
{
    public class UserClaimsType : ObjectType<UserClaims>
    {
        protected override void Configure(IObjectTypeDescriptor<UserClaims> descriptor)
        {
            base.Configure(descriptor);
            descriptor.Field(a => a.Id)
                .Type<NonNullType<IntType>>();
            descriptor.Field(a => a.UserID)
                .Type<NonNullType<IntType>>();
            descriptor.Field(a => a.Type)
                .Type<NonNullType<StringType>>();
            descriptor.Field(a => a.Value)
                .Type<NonNullType<StringType>>();
            descriptor.Field(a => a.LastUpdated)
                .Type<NonNullType<DateTimeType>>();
            descriptor.Field(a => a.UserGuid)
                .Type<UuidType>();
            descriptor.Field(a => a.PublicKey)
                .Type<NonNullType<UuidType>>();
            descriptor.Field(a => a.ClientGuid)
                .Type<NonNullType<UuidType>>();
        }
    }
}
