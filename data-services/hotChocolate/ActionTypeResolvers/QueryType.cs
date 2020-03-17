using CX_Graphql.Resolvers;
using CX_Graphql.Types;
using CX_Identity.Types;
using HotChocolate.Types;

namespace CX_Graphql.ActionTypeResolvers
{
    public class QueryType : ObjectType<Query>
    {
        protected override void Configure(IObjectTypeDescriptor<Query> descriptor)
        {
            base.Configure(descriptor);

            descriptor.Field(q => q.GetClients(default))
               .Type<ListType<NonNullType<ClientType>>>().UseFiltering().UseSorting();

            descriptor.Field(q => q.GetClientUIInfos(default))
               .Type<ListType<NonNullType<ClientUIInfosType>>>().UseFiltering().UseSorting();

            descriptor.Field(q => q.GetUsers(default))
               .Type<ListType<NonNullType<UserType>>>().UseFiltering().UseSorting();

            descriptor.Field(q => q.GetUserClaims(default))
                .Type<ListType<NonNullType<UserClaimsType>>>().UseFiltering().UseSorting();
        }
    }
}
